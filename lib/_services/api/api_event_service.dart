import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/schedule_model.dart';
import 'package:app_qldt/_utils/secret/secret.dart';

class EventService {
  final String idUser;
  int localVersion;

  EventService({
    required this.idUser,
    required this.localVersion,
  });

  Future<List<ScheduleModel>?> getRawData() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        List? data = await _fetchData();

        if (data != null) {
          return data as List<ScheduleModel>;
        }

        return null;
      } on Exception catch (e) {
        print(e);
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
    String url = '${Secret.url.getRequest.schedule}?id=$idUser&version=$localVersion';

    try {
      http.Response responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      switch (responseData.statusCode) {
        case 200:
          List data = jsonDecode(responseData.body)['data'] as List;
          List<ScheduleModel> listModel = [];

          for (var element in data) {
            listModel.add(ScheduleModel.fromJson(element));
          }

          localVersion = jsonDecode(responseData.body)['data_version'];
          return listModel;

        case 204:
          return [];

        default:
          print("Error with status code: ${responseData.statusCode} at api_event_service.dart");
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
