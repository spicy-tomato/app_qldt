import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/schedule.dart';

class EventService {
  static final _timeout = 5;
  static final _baseUrl =
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_schedule.php?id=';

  final String studentId;

  EventService(this.studentId);

  Future<List<Schedule>?> getRawScheduleData() async {
    try {
      List? data = await _fetchData();

      if (data != null) {
        return data as List<Schedule>;
      }

      return null;
    } on Exception catch (_) {
      throw Exception('Cannot parse date');
    }
  }

  Future<List?> _fetchData() async {
    String url = _baseUrl + studentId;

    try {
      final responseData =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: _timeout));

      if (responseData.statusCode == 200) {
        List data = jsonDecode(responseData.body) as List;
        List<Schedule> listModel = [];

        for (var element in data) {
          listModel.add(Schedule.fromJson(element));
        }

        return listModel;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode}");
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e at Event service');
    } on SocketException catch (e) {
      print('Socket error: $e at Event service');
    } on Error catch (e) {
      print('General Error: $e at Event service');
    }

    return null;
  }
}
