import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/schedule_model.dart';
import 'package:app_qldt/_utils/secret/secret.dart';

class EventService {
  final String userId;

  EventService(this.userId);

  Future<List<ScheduleModel>?> getRawData() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        List? data = await _fetchData();

        if (data != null) {
          return data as List<ScheduleModel>;
        }

        return null;
      } on Exception catch (_) {
        throw Exception('Cannot parse date');
      }
    }

    return null;
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
  Future<List<ScheduleModel>?> _fetchData() async {
    String url = Secret.url.getRequest.schedule + '?id_student=' + userId;

    try {
      http.Response responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      switch (responseData.statusCode) {
        case 200:
          List data = jsonDecode(responseData.body) as List;
          List<ScheduleModel> listModel = [];

          for (var element in data) {
            listModel.add(ScheduleModel.fromJson(element));
          }

          return listModel;

        case 204:
          return [];

        default:
          print("Error with status code: ${responseData.statusCode} at event_service.dart");
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
