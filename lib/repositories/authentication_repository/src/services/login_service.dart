import 'dart:convert';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/http/response.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class LoginService {
  final ApiUrl apiUrl;

  const LoginService(this.apiUrl);

  Future<HttpResponseModel> login(LoginUser loginUser) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return HttpResponseModel(status: HttpResponseStatus.noInternetConnection);
    }

    final String url = apiUrl.post.authentication;
    final String body = jsonEncode(loginUser);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response? response;

    try {
      response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: body,
          )
          .timeout(Const.requestTimeout);

      final HttpResponseStatus status = statusFromCode(response.statusCode);

      return HttpResponseModel(
        status: status,
        data: status.isSuccessfully ? response.body : null,
      );
    } on Exception catch (e) {
      debugPrint('Error: $e in Login service');
      return HttpResponseModel(status: HttpResponseStatus.serverError);
    }
  }
}
