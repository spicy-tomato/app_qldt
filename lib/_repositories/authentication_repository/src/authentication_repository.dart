import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/_services/local_event_service.dart';
import 'package:app_qldt/_services/local_notification_service.dart';
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

    String? response = await _loginService.login();
    LoginResponse loginResponse;

    if (response != null) {
       loginResponse = LoginResponse.fromJson(jsonDecode(response));
    }
    else {
      _controller.add(AuthenticationStatus.unauthenticated);
      return false;
    }

    if (loginResponse.message == 'success') {
      await _saveUserInfo(jsonEncode(loginResponse.info));
      _controller.add(AuthenticationStatus.authenticated);
      return true;
    }

    _controller.add(AuthenticationStatus.unauthenticated);
    return false;
  }

  Future<void> _saveUserInfo(String info) async {
    final prefs = await SharedPreferences.getInstance();
    // print(info);
    prefs.setString('user_info', info);
  }

  Future<void> logOut() async {
    await _removeLocalEvent();
    await _removeLocalNotification();
    await _removeUserInfo();

    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }

  Future<void> _removeLocalEvent() async {
    await LocalEventService.delete();
  }

  Future<void> _removeLocalNotification() async {
    await LocalNotificationService.delete();
  }

  Future<void> _removeUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_info');
  }

}
