import 'package:app_qldt/screens/firebase/firebase.dart';
import 'package:http/http.dart';

const baseUrl =
    'http://ancolincode.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';

void upsertToken(Firebase firebase, String studentId) async {
  String token = await firebase.getToken();

  // Map<String, String> headers = {
  //   "Content-type": "application/json",
  // };

  String body = '{'
      '"student_id": "$studentId",'
      '"token": "$token"'
      '}';

  print(body);

  Response response = await post(
    baseUrl,
    // headers: headers,
    body: body,
  );

  String rbody = response.body;

  print(rbody);
}
