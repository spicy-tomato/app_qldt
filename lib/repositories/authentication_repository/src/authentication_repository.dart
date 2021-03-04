import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/services.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get stream async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    @required String? id,
    @required String? password,
  }) async {
    assert(id != null);
    assert(password != null);

    final _loginUser = LoginUser(id!, password!);
    final _loginService = LoginService(_loginUser);

    String response = await _loginService.login();
    LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response));

    if (loginResponse.message == 'success') {
      await _saveUserInfo(jsonEncode(loginResponse.info));
      _controller.add(AuthenticationStatus.authenticated);
      return true;
    }

    _controller.add(AuthenticationStatus.unauthenticated);
    return false;
  }

  Future<void> logOut() async {
    await _removeUserInfo();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    print('----- Disposed ------');
    _controller.close();
  }

  Future<void> _saveUserInfo(String info) async {
    final prefs = await SharedPreferences.getInstance();
    // print(info);
    prefs.setString('user_info', info);
  }


  Future<void> _removeUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_info');
  }
}
