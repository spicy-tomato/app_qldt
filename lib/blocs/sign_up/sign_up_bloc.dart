import 'dart:convert';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/form/form.dart';
import 'package:app_qldt/models/http/response.dart';
import 'package:app_qldt/models/sign_up/sign_up_user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class LoginService {
  final ApiUrl apiUrl;

  const LoginService(this.apiUrl);

  Future<HttpResponseModel> login(SignUpUser loginUser) async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      return HttpResponseModel(status: HttpResponseStatus.noInternetConnection);
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

      final HttpResponseStatus status = statusFromCode(response.statusCode);
      status.isSuccessfully;

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
