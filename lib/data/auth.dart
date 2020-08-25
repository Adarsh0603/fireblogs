import 'dart:convert';

import 'package:fireblogs/data/apikeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
  }

  Future<void> _authenticate(
      String email, String password, String method) async {
    var url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$method?key=$apiKey";
    final response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    final userData = jsonDecode(response.body);
    _token = userData['idToken'];
    _userId = userData['localId'];
    _expiryDate =
        DateTime.now().add(Duration(seconds: int.parse(userData['expiresIn'])));
    print(_expiryDate);
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logOut() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
  }
}
