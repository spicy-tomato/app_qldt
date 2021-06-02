import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_services/web/exception/no_exam_schedule_data_exception.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/secret.dart';
import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart' as http;

class ExamScheduleService {
  final String userId;

  ExamScheduleService(this.userId);

  Future<List<ExamScheduleModel>?> getExamSchedule() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        List? rawData = await _fetchData();
        return _parseData(rawData);
      } on NoExamScheduleDataException catch (e) {
        throw (e);
      } on Exception catch (e) {
        print(e);
      }
    }
    return null;
  }

  /// [responseData] has structure:
  /// [
  ///     {
  ///         "Semester":               [String]
  ///         "Module_Name":            [String]
  ///         "Credit":                 [int]
  ///         "Date_Start":             [String]
  ///         "Time_Start":             [String]
  ///         "Method":                 [String]
  ///         "Identification_Number":  [int]
  ///         "Room":                   [String]
  ///     },
  ///     ...
  /// ]
  Future<List?> _fetchData() async {
    String url = Secret.url.getRequest.examSchedule + '?id=' + userId;

    try {
      final responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);

      if (responseData.statusCode == 200) {
        if (jsonDecode(responseData.body) is String) {
          throw NoExamScheduleDataException();
        }

        return jsonDecode(responseData.body) as List;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode} at ExamSchedule service");
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e at ExamSchedule service');
    } on SocketException catch (e) {
      print('Socket error: $e at ExamSchedule service');
    } on Error catch (e) {
      print('General Error: $e at ExamSchedule service');
    }

    return null;
  }

  List<ExamScheduleModel>? _parseData(List? rawData) {
    if (rawData == null) {
      return null;
    }

    List<ExamScheduleModel> listModel = [];

    for (var element in rawData) {
      listModel.add(ExamScheduleModel.fromJson(element));
    }

    return listModel;
  }
}
