import 'dart:convert';
import 'package:http/http.dart';

import 'models/models.dart';

class LoginService {
  final LoginUser loginUser;

  const LoginService(this.loginUser);

  Future<String> login() async {
    const baseUrl =
        'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/authentication.php';

    String body = jsonEncode(loginUser);

    Response response;

    try {
      response = await post(
        Uri.parse(baseUrl),
        // headers: headers,
        body: body,
      );
      return response.body;
    } on Exception catch (e) {
      print(e);
      return "";
    }
  }
}
