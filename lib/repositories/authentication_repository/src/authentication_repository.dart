import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/core/response_model.dart';
import 'package:app_qldt/models/http/response.dart';
import 'package:app_qldt/repositories/user_repository/src/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/services.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

extension AuthenticationStatusExtension on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;

  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;

  bool get isUnknown => this == AuthenticationStatus.unknown;
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>.broadcast();
  LoginService? _loginService;

  Stream<AuthenticationStatus> get stream async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<HttpResponseStatus> logIn(ApiUrl apiUrl, LoginUser loginUser) async {
    _loginService ??= LoginService(apiUrl);

    final HttpResponseModel loginResponse = await _loginService!.login(loginUser);

    if (loginResponse.status.isSuccessfully) {
      try {
        final response = ResponseModel<User>.fromJson(jsonDecode(loginResponse.data!));
        final User userInfo = response.data;

        await _saveUserInfo(userInfo);
        _controller.add(AuthenticationStatus.authenticated);
      } on Exception {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    return loginResponse.status;
  }

  Future<void> _saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_info', jsonEncode(user));
  }

  Future<void> logOut() async {
    debugPrint('${DateTime.now()}: Request to logout');

    await DatabaseProvider.deleteDb();
    await _removeUserInfo();
  }

  Future<void> dispose() async {
    await _controller.close();
  }

  Future<void> _removeUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_info');
  }
}
