import 'dart:async';

import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/services.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>.broadcast();

  Stream<AuthenticationStatus> get stream async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<LoginStatus> logIn(ApiUrl apiUrl, LoginUser loginUser) async {
    final loginService = LoginService(apiUrl, loginUser);
    final LoginResponse loginResponse = await loginService.login();

    print('Login status: ${loginResponse.status}');

    if (loginResponse.status.isSuccessfully) {
      await _saveUserInfo(loginResponse.data!);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    return loginResponse.status;
  }

  Future<void> _saveUserInfo(String info) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_info', info);
  }

  Future<void> logOut() async {
    await DatabaseProvider.deleteDb();
    await _removeUserInfo();

    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }

  Future<void> _removeUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_info');
  }
}
