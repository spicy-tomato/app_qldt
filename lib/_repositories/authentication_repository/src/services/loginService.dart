import 'dart:convert';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

extension LoginStatusExtension on LoginStatus {
  bool get isSuccessfully => this == LoginStatus.successfully;
}

class LoginService {
  final ApiUrl apiUrl;
  final LoginUser loginUser;

  const LoginService(this.apiUrl, this.loginUser);

  Future<LoginResponse> login() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return LoginResponse(status: LoginStatus.noInternetConnection);
    }

    String url = apiUrl.post.authentication;
    String body = jsonEncode(loginUser);

    http.Response? response;

    try {
      response = await http
          .post(
            Uri.parse(url),
            body: body,
          )
          .timeout(Const.requestTimeout);

      LoginStatus status = statusFromCode(response.statusCode);

      return LoginResponse(status: status, data: status.isSuccessfully ? response.body : null);
    } on Exception catch (e) {
      print('Error: $e in Login service');
      return LoginResponse(status: LoginStatus.serverError);
    }
  }
}
