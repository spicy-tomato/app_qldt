import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    Map<String, dynamic> loginInfo = await _getSavedLoginInfo();

    if (loginInfo == null) return User.empty;

    _user = User.fromJson(loginInfo);
    return _user;
  }

  Future<Map<String, dynamic>> _getSavedLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString('user_info'));
  }
}
