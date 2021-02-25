import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    if (_user != null) return _user;

    String loginInfo = await _getSavedLoginInfo();
    _user = User(loginInfo);

    return _user;
  }

  Future<String> _getSavedLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('student_id');
  }
}
