import 'dart:convert';
import 'package:http/http.dart';

import 'models/models.dart';

class LoginService {
  final LoginUser loginUser;
  final _timeout = 10;

  const LoginService(this.loginUser);

  Future<String?> login() async {
    const baseUrl =
        'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/authentication.php';

    String body = jsonEncode(loginUser);

    Response? response;

    try {
      response = await post(
        Uri.parse(baseUrl),
        body: body,
      ).timeout(Duration(seconds: _timeout));
    } on Exception catch (e) {
      print('Error: $e in Login service');
      return null;
    }

    // print(response.body);

    return response.body;
  }
}
