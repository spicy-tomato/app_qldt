import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:app_qldt/models/service/user_data_model.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class UserRepository {
  late User _user;
  late UserDataModel userDataModel;

  Future<User?> getUser() async {
    final Map<String, dynamic> loginInfo = await _getSavedLoginInfo();

    if (loginInfo.isEmpty) {
      return null;
    }

    debugPrint(loginInfo.toString());

    try {
      final permission = await _getPermission();
      _user = User.fromJsonWithPermission(loginInfo, permission);
    } on Exception catch (e){
      debugPrint(e.toString());
    }

    return _user;
  }

  Future<Map<String, dynamic>> _getSavedLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? infoStr = prefs.getString('user_info');

    if (infoStr == null){
      return {};
    }

    return jsonDecode(infoStr);
  }

  Future<AccountPermission> _getPermission() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('permission')!;
    return AccountPermission.values[index];
  }
}
