import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/app_notification_model.dart';
import 'package:app_qldt/_models/receive_notification_model.dart';
import 'package:app_qldt/_models/sender_model.dart';
import 'package:app_qldt/_utils/secret/secret.dart';

class NotificationService {
  final String studentId;

  NotificationService(this.studentId);

  Future<AppNotificationModel?> getNotification() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        Map<String, dynamic>? data = await _fetchData();

        if (data != null) {
          if (data.isNotEmpty) {
            List<SenderModel> senderList = SenderModel.fromList(data['sender']);
            List<ReceiveNotificationModel> notificationList =
                ReceiveNotificationModel.fromList(data['notification']);

            return AppNotificationModel(notificationList, senderList);
          }

          return AppNotificationModel([], []);
        }

        return null;
      } on Exception catch (e) {
        print('Error: $e at notification_service.dart, getNotification()');
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> _fetchData() async {
    String url = Secret.url.getRequest.notification + '?id=' + studentId;

    try {
      final responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);

      switch (responseData.statusCode) {
        case 200:
          return jsonDecode(responseData.body);

        case 204:
          return {};

        default:
          print("Error with status code: ${responseData.statusCode} at notification_service.dart, _fetchData()");
          return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e at Notification service');
    } on SocketException catch (e) {
      print('Socket error: $e at Notification service');
    } on Error catch (e) {
      print('General Error: $e at Notification service');
    }

    return null;
  }
}
