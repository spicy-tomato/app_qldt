import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_qldt/models/schedule.dart';

class CalenderService {
  static final timeout = 10;
  static final baseUrl =
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_schedule.php?id=';

  static Future<List<Schedule>> getRawCalendarData(String studentId) async {
    try {
      List data = await CalenderService._fetchData(studentId);

      if (data != null) {
        return data as List<Schedule>;
      }

      return null;
    } catch (Exception) {
      throw Exception('Cannot parse date');
    }
  }

  static Future<List> _fetchData(String studentId) async {
    String url = baseUrl + studentId;

    try {
      final responseData =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: timeout));

      if (responseData.statusCode == 200) {
        List data = jsonDecode(responseData.body) as List;
        List<Schedule> listModel = [];
        data.forEach((element) {
          listModel.add(Schedule.fromJson(element));
        });
        return listModel;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode}");
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e');
    } on SocketException catch (e) {
      print('Socket error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }

    return null;
  }
}
