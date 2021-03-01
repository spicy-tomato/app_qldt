import 'package:http/http.dart';
import 'package:firebase_repository/firebase_repository.dart';

class TokenService {
  static final _baseUrl =
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';

  static upsert(FirebaseRepository firebase, String studentId) async {
    String token = await firebase.getToken();

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
