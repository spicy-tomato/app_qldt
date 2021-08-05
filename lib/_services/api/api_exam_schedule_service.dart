import 'dart:async';
import 'dart:io';

import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

class ApiExamScheduleService extends ApiService {
  ApiExamScheduleService({
    required String idUser,
    required ApiUrl apiUrl,
  }) : super(
          idUser: idUser,
          apiUrl: apiUrl,
        );

  Future<ServiceResponse> request() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      return await _fetchData();
    }

    return ServiceResponse.offline();
  }

  /// [responseData] has structure:
  /// [
  ///     {
  ///         "School_Year:             [String]
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
  Future<ServiceResponse> _fetchData() async {
    String baseUrl = apiUrl.get.examSchedule;
    int version = controller.localService.databaseProvider.dataVersion.examSchedule;

    String url = '$baseUrl?id_student=$idUser&version=$version';

    try {
      final response = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      return ServiceResponse(response);
    } on TimeoutException catch (e) {
      debugPrint('Timeout error: $e at ExamSchedule service');
    } on SocketException catch (e) {
      debugPrint('Socket error: $e at ExamSchedule service');
    } on Error catch (e) {
      debugPrint('General Error: $e at ExamSchedule service');
    }

    return ServiceResponse.error();
  }
}
