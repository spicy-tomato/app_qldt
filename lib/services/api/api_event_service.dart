import 'dart:async';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/constant/permission.constant.dart';
import 'package:app_qldt/repositories/user_repository/src/models/user.dart';
import 'package:app_qldt/services/api/api_service.dart';
import 'package:app_qldt/services/model/service_response.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http_interceptor/http_interceptor.dart';

//import 'package:http/http.dart' as http;

import 'header_interceptor.dart';

class ApiEventService extends ApiService {
  ApiEventService({
    required User user,
    required ApiUrl apiUrl,
  }) : super(
          user: user,
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
    final String baseUrl = (user.grantedPermissions?.contains(
                PermissionConstant.REQUEST_CHANGE_TEACHING_SCHEDULE) ??
            false)
        ? apiUrl.get.teacherSchedule
        : apiUrl.get.schedule;
    final client = InterceptedClient.build(interceptors: [
      HeaderInterceptor(),
    ]);

    debugPrint('$baseUrl at Event service');

    final int version =
        controller.localService.databaseProvider.dataVersion.schedule;
    final String url = '$baseUrl?id=$user&version=$version';

    try {
      final response =
          await client.get(Uri.parse(url)).timeout(Const.requestTimeout);
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
