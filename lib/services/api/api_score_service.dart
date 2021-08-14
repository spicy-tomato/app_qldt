import 'dart:async';
import 'dart:io';

import 'package:app_qldt/services/api/api_service.dart';
import 'package:app_qldt/services/model/service_response.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiScoreService extends ApiService {
  ApiScoreService({
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
  ///         "Semester":           [String],
  ///         "Module_Name":        [String],
  ///         "Credit":             [int],
  ///         "Evaluation":         [String],
  ///         "Process_Score":      [double]
  ///         "Test_Score":         [double]
  ///         "Theoretical_Score":  [double]
  ///     },
  ///     ...
  /// ]
  Future<ServiceResponse> _fetchData() async {
    String baseUrl = apiUrl.get.score;
    int version = controller.localService.databaseProvider.dataVersion.score;

    String url = '$baseUrl?id_student=$idUser&version=$version';

    try {
      final response = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      return ServiceResponse(response);
    } on TimeoutException catch (e) {
      debugPrint('Timeout error: $e at Score service');
    } on SocketException catch (e) {
      debugPrint('Socket error: $e at Score service');
    } on Error catch (e) {
      debugPrint('General Error: $e at Score service');
    }

    return ServiceResponse.error();
  }
}
