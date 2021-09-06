import 'dart:convert';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

extension LoginStatusExtension on LoginStatus {
  bool get isSuccessfully => this == LoginStatus.successfully;
}

class LoginService {
  final ApiUrl apiUrl;

  const LoginService(this.apiUrl);

  Future<LoginResponse> login(LoginUser loginUser) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return LoginResponse(status: LoginStatus.noInternetConnection);
    }

    final String url = apiUrl.post.authentication;
    final String body = jsonEncode(loginUser);

    http.Response? response;

    try {
      response = await http
          .post(
            Uri.parse(url),
            body: body,
          )
          .timeout(Const.requestTimeout);

      final LoginStatus status = statusFromCode(response.statusCode);

      return LoginResponse(
        status: status,
        data: status.isSuccessfully ? response.body : null,
      );
    } on Exception catch (e) {
      debugPrint('Error: $e in Login service');
      return LoginResponse(status: LoginStatus.serverError);
    }
  }
}
