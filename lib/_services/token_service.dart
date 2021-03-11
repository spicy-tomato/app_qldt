import 'package:http/http.dart';
import 'package:app_qldt/_repositories/firebase_repository/firebase_repository.dart';

class TokenService {
  late final FirebaseRepository _firebaseRepository = new FirebaseRepository();
  static final _baseUrl =
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';

  Future<void> init() async{
    await _firebaseRepository.initialise();
  }

  Future<void> upsert(String studentId) async {
    String? token = await _firebaseRepository.getToken();

    print('Token: $token');

    String body = '{'
        '"student_id": "$studentId",'
        '"token": "$token"'
        '}';

    Response response = await post(
      Uri.parse(_baseUrl),
      // headers: headers,
      body: body,
    );

    print('Upsert token status: ${response.body}');
  }
}
