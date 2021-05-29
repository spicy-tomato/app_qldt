import 'dart:convert';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/secret.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class LoginService {
  final LoginUser loginUser;

  const LoginService(this.loginUser);

  Future<String?> login() async {
    String url = Secret.url.postRequest.authentication;
    String body = jsonEncode(loginUser);

    http.Response? response;

    try {
      response = await http
          .post(
            Uri.parse(url),
            body: body,
          )
          .timeout(Const.requestTimeout);
      return response.body;
    } on Exception catch (e) {
      print('Error: $e in Login service');
      return null;
    }
  }
}
