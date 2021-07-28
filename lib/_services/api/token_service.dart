import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/_repositories/firebase_repository/firebase_repository.dart';

class TokenService {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();
  final ApiUrl apiUrl;

  TokenService(this.apiUrl);

  Future<void> init() async {
    await _firebaseRepository.initialise();
  }

  Future<void> upsert(String studentId) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      String? token = await _firebaseRepository.getToken();
      print('Token: $token');

      final json = <String, String?>{
        'id_student': studentId,
        'token': token,
      };

      http.Response response;

      try {
        response = await http
            .post(
              Uri.parse(apiUrl.post.upsertToken),
              body: jsonEncode(json),
            )
            .timeout(Const.requestTimeout);
      } on Exception catch (e) {
        print('Error: $e in Token service');
        return;
      }

      print('Upsert token status: ${response.body}');
    } else {
      print('Token Service: Do not upsert since no internet connection');
    }
  }
}
