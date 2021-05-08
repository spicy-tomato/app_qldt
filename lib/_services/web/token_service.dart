import 'dart:convert';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/secret.dart';
import 'package:http/http.dart';

import 'package:app_qldt/_repositories/firebase_repository/firebase_repository.dart';

class TokenService {
  late final FirebaseRepository _firebaseRepository = FirebaseRepository();

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
        Uri.parse(Secret.url.postRequest.upsertToken),
        body: jsonEncode(json),
      ).timeout(Const.requestTimeout);
    } on Exception catch (e) {
      print('Error: $e in Token service');
      return;
    }

    print('Upsert token status: ${response.body}');
  }
}
