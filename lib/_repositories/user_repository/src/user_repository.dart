import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/_models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/models.dart';

class UserRepository {
  late User _user;
  late UserDataModel userDataModel;

  Future<User?> getUser() async {
    Map<String, dynamic> loginInfo = await _getSavedLoginInfo();

    if (loginInfo.isEmpty) return null;

    print(loginInfo);

    try {
      _user = User.fromJson(loginInfo);
    } on Exception catch (e){
      print(e.toString());
    }

    return _user;
  }

  Future<Map<String, dynamic>> _getSavedLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? infoStr = prefs.getString('user_info');

    if (infoStr == null){
      return new Map();
    }

    return jsonDecode(infoStr);
  }
}
