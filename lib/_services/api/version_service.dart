import 'dart:convert';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_utils/secret/url/url.dart';

class VersionService {
  final ApiUrl apiUrl;
  final String idStudent;

  VersionService({
    required this.apiUrl,
    required this.idStudent,
  });

  Future<Map<String, dynamic>> getServerDataVersion() async {
    String baseUrl = apiUrl.get.version;
    http.Response response;

    String url = '$baseUrl?id=$idStudent';
    print(url);

    try {
      response = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      return jsonDecode(response.body);
    } on Exception catch (e) {
      print('Error: $e in Version service - getServerDataVersion()');
      return Map();
    }
  }
}
