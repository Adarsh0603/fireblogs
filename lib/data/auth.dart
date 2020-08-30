import 'dart:async';
import 'dart:convert';
import 'package:fireblogs/data/apikeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fireblogs/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  String _refreshToken;
  DateTime _expiryDate;
  Timer _authTimer;
  String _username;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get username {
    return _username;
  }

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  String get userId {
    return _userId;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    var extractedData =
        await jsonDecode(prefs.getString('userData')) as Map<String, dynamic>;
    var expiryDate = DateTime.parse(extractedData['expiryDate']);
    _refreshToken = extractedData['refreshToken'];

    if (expiryDate.isBefore(DateTime.now())) {
      try {
        await _getNewToken();
        extractedData = await jsonDecode(prefs.getString('userData'))
            as Map<String, dynamic>;
        expiryDate = DateTime.parse(extractedData['expiryDate']);
      } catch (e) {
        logOut();
      }
    }
    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _refreshToken = extractedData['refreshToken'];
    _expiryDate = expiryDate;
    await _getNewToken();
    await fetchUserDetails();
    notifyListeners();
    _autoRefreshToken();
    return true;
  }

  Future<void> fetchUserDetails() async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/users/$_userId.json?auth=$_token";
    var response = await http.get(url);
    var userData = jsonDecode(response.body);
    _username = userData['username'];
    notifyListeners();
  }

  Future<void> _authenticate(
      String email, String password, String method) async {
    var url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$apiKey";
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (responseData.containsKey('error')) _errorHandling(responseData);
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        _token = userData['idToken'];
        _userId = userData['localId'];
        _refreshToken = userData['refreshToken'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(userData['expiresIn']),
          ),
        );
        _autoRefreshToken();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userDataToSave = jsonEncode({
          'token': _token,
          'userId': _userId,
          'refreshToken': _refreshToken,
          'expiryDate': _expiryDate.toIso8601String()
        });
        prefs.setString('userData', userDataToSave);
      } else {
        throw 'Cant Login';
      }
    } on HttpException {
      rethrow;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(String email, String password, String username) async {
    try {
      await _authenticate(email, password, 'signUp');
      final url =
          "https://fireblogs-da7f6.firebaseio.com/users/$_userId.json?auth=$_token";
      await http.put(url,
          body: json.encode({
            "username": username,
          }));
      fetchUserDetails();
    } on HttpException {
      rethrow;
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authenticate(email, password, 'signInWithPassword');

      fetchUserDetails();
    } on HttpException {
      rethrow;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logOut() async {
    _token = null;
    _expiryDate = null;
    _refreshToken = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoRefreshToken() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry - 10), _getNewToken);
  }

  Future<void> _getNewToken() async {
    final url = 'https://securetoken.googleapis.com/v1/token?key=$apiKey';
    var response = await http.post(url,
        body: jsonEncode(
            {'grant_type': 'refresh_token', 'refresh_token': _refreshToken}));
    var responseData = jsonDecode(response.body);
    _token = responseData['access_token'];
    _refreshToken = responseData['refresh_token'];
    _userId = responseData['user_id'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseData['expires_in']),
      ),
    );
    notifyListeners();
    _autoRefreshToken();
    final prefs = await SharedPreferences.getInstance();
    final userDataToSave = jsonEncode({
      'token': _token,
      'userId': _userId,
      'refreshToken': _refreshToken,
      'expiryDate': _expiryDate.toIso8601String()
    });
    prefs.setString('userData', userDataToSave);
  }

  void _errorHandling(Map errorMap) {
    String exceptionMessage = '';
    final message = errorMap['error']['message'];
    switch (message) {
      case 'INVALID_EMAIL':
        exceptionMessage = 'The email is invalid';
        break;
      case 'EMAIL_NOT_FOUND':
        exceptionMessage = "This email does not exist.";
        break;
      case 'EMAIL_EXISTS':
        exceptionMessage = 'The email already exists';
        break;
      case 'INVALID_PASSWORD':
        exceptionMessage = 'The password is invalid.Try again';
        break;
      case 'WEAK_PASSWORD':
        exceptionMessage = 'The password must be 6 characters long or more.';
        break;
      default:
        exceptionMessage =
            'Could not authenticate you. Please try again later.';
    }
    throw HttpException(exceptionMessage);
  }
}
