import 'dart:async';
import 'dart:io';

import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class ApiNotificationService extends ApiService {
  final String idAccount;

  ApiNotificationService({
    required this.idAccount,
    required String idStudent,
    required ApiUrl apiUrl,
  }) : super(
          idUser: idStudent,
          apiUrl: apiUrl,
        );

  Future<ServiceResponse> requestAll() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      return await _fetchData();
    }

    return ServiceResponse.offline();
  }

  Future<ServiceResponse> request() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      int? idNotification = await controller.localService.databaseProvider.notification.lastId;
      return await _fetchData(idNotification: idNotification);
    }

    return ServiceResponse.offline();
  }

  Future<ServiceResponse> _fetchData({int? idNotification}) async {
    String baseUrl = apiUrl.get.notification;
    int version = controller.localService.databaseProvider.dataVersion.notification;

    String url = '$baseUrl?id_student=$idUser&id_account=$idAccount&version=$version';
    if (idNotification != null){
      url += '&id_notification=$idNotification';
    }

    try {
      final response = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);
      return ServiceResponse.withVersion(response);
    } on TimeoutException catch (e) {
      print('Timeout error: $e at API Notification service');
    } on SocketException catch (e) {
      print('Socket error: $e at API Notification service');
    } on Error catch (e) {
      print('General Error: $e at API Notification service');
    }

    return ServiceResponse.error();
  }
}
