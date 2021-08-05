import 'dart:async';
import 'dart:io';

import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiEventService extends ApiService {
  ApiEventService({
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
  ///         "Module_Class_Name":  [String],
  ///         "ID_Module_Class":    [String],
  ///         "ID_Room":            [String],
  ///         "Shift_Schedules":    [int],
  ///         "Day_Schedules":      [String]
  ///     },
  ///     ...
  /// ]
  Future<ServiceResponse> _fetchData() async {
    String baseUrl = apiUrl.get.schedule;
    int version = controller.localService.databaseProvider.dataVersion.schedule;

    String url = '$baseUrl?id=$idUser&version=$version';

    try {
      http.Response response = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      return ServiceResponse.withVersion(response);
    } on TimeoutException catch (e) {
      debugPrint('Timeout error: $e at Event service');
    } on SocketException catch (e) {
      debugPrint('Socket error: $e at Event service');
    } on Error catch (e) {
      debugPrint('General Error: $e at Event service');
    }

    return ServiceResponse.error();
  }
}
