import 'dart:convert';

import 'package:fireblogs/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserProfile with ChangeNotifier {
  String _authToken;
  String _userId;

  String _username;
  String _userDetails;

  void update(String token, String user, String userName) {
    _authToken = token;
    _userId = user;
  }

  String get username => _username;
  String get userDetails => _userDetails;

  Future<void> savedData() async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/users/$_userId.json?auth=$_authToken";
    var response = await http.get(url);
    var savedDataResponse = jsonDecode(response.body);
    _username = savedDataResponse['username'];
    _userDetails = savedDataResponse['userDetails'];
    notifyListeners();
  }

  Future<void> updateProfile(String userName, String userDetails) async {
    try {
      final url =
          "https://fireblogs-da7f6.firebaseio.com/users/$_userId.json?auth=$_authToken";
      await http.put(url,
          body:
              json.encode({"username": userName, "userDetails": userDetails}));
    } on HttpException {
      rethrow;
    } catch (e) {
      print(e);
    }
  }
}
