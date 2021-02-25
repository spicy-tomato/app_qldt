import 'package:http/http.dart';
import 'package:firebase_repository/firebase_repository.dart';

const baseUrl =
    'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';

void upsertToken(FirebaseRepository firebase, String studentId) async {
  String token = await firebase.getToken();

  print(token);
  print(studentId);

  // Map<String, String> headers = {
  //   "Content-type": "application/json",
  // };

  String body = '{'
      '"student_id": "$studentId",'
      '"token": "$token"'
      '}';

  // final directory = await getApplicationDocumentsDirectory();
  // print(directory.path);

  Response response = await post(
    baseUrl,
    // headers: headers,
    body: body,
  );

  String rbody = response.body;

  print('-- Upsert token -- Response body: $rbody');
}
