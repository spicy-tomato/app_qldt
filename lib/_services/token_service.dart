import 'dart:convert';

import 'package:http/http.dart';
import 'package:app_qldt/_repositories/firebase_repository/firebase_repository.dart';

class TokenService {
  late final FirebaseRepository _firebaseRepository = FirebaseRepository();
  static final _baseUrl =
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';
  static final _timeout = 5;

  Future<void> init() async {
    await _firebaseRepository.initialise();
  }

  Future<void> upsert(String studentId) async {
    String? token = await _firebaseRepository.getToken();

    print('token: $token');

    final json = <String, String?>{
      'student_id': studentId,
      'token': token,
    };

    Response response;

    try {
      response = await post(
        Uri.parse(_baseUrl),
        body: jsonEncode(json),
      ).timeout(Duration(seconds: _timeout));
    } on Exception catch (e) {
      print('Error: $e in Token service');
      return;
    }

    print('Upsert token status: ${response.body}');
  }
}
