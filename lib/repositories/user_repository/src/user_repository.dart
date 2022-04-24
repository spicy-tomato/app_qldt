import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/models/service/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class UserRepository {
  late UserDataModel userDataModel;

  Future<User?> getUser() async => await _getSavedLoginInfo();

  Future<User?> _getSavedLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? infoStr = prefs.getString('user_info');

    return infoStr == null ? null : User.fromJson(jsonDecode(infoStr));
  }
}
