import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/9/2022
 * Time: 11:55 AM
 */
class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiredTime = DateTime.now();
  String _userId = '';
  Timer? _authTimer;

  String get userId => _userId;

  bool get isAuth {
    return token != '';
  }
  String get token {
    if( _expiredTime.isAfter(DateTime.now()) && _token != '') {
      return _token;
    }
    return '';
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async{
    final signupUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCLpEQHKObkOpJBMagFxwdPyRYyWnYggzA';
    final response = await http.post(Uri.parse(signupUrl),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    print(responseData);
    if(responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiredTime = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
    _autoLogout();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiredTime': _expiredTime.toIso8601String()
    });
    prefs.setString('userData', userData);
    notifyListeners();
    print(responseData['expiresIn']);
  }
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiredTime = DateTime.parse(extractedUserData['expiredTime']);
    if(expiredTime.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiredTime = expiredTime;
    notifyListeners();
    _autoLogout();
    return true;
  }
  Future<void> logout() async{
    _token = '';
    _expiredTime = DateTime.now();
    _userId = '';
    _authTimer?.cancel();
    _authTimer = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    _authTimer?.cancel();
    final expiredTimeSeconds = _expiredTime.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiredTimeSeconds), logout);
  }
}
