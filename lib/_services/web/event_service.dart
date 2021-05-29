import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/schedule.dart';
import 'package:app_qldt/_utils/secret/secret.dart';

class EventService {
  final String userId;

  EventService(this.userId);

  Future<List<Schedule>?> getRawData() async {
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

  /// [responseData] has structure:
  /// [
  ///     {
  ///         "Module_Class_Name":  [String],
  ///         "ID_Module_Class":    [String],
  ///         "ID_Room":            [String],
  ///         "Shift_Schedules":    [int],
  ///         "Day_Schedules":      [String]
  ///     },
  ///     ...
  /// ]
  Future<List<Schedule>?> _fetchData() async {
    String url = Secret.url.getRequest.schedule + '?id=' + userId;

    try {
      http.Response responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);

      if (responseData.statusCode == 200) {
        List data = jsonDecode(responseData.body) as List;
        List<Schedule> listModel = [];

        for (var element in data) {
          listModel.add(Schedule.fromJson(element));
        }

        return listModel;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode} at Event Service");
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
