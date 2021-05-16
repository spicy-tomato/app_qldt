import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/app_notification.dart';
import 'package:app_qldt/_models/receive_notification.dart';
import 'package:app_qldt/_models/sender.dart';
import 'package:app_qldt/_utils/secret/secret.dart';

class NotificationService {
  final String studentId;

  NotificationService(this.studentId);

  Future<AppNotification?> getNotification() async {
    try {
      Map<String, dynamic>? data = await _fetchData();

      if (data != null) {
        List<Sender> senderList = Sender.fromList(data['sender']);
        List<ReceiveNotification> notificationList =
            ReceiveNotification.fromList(data['notification']);

        return AppNotification(notificationList, senderList);
      }

      return null;
    } on Exception catch (_) {
      throw Exception('Cannot parse');
    }
  }

  Future<Map<String, dynamic>?> _fetchData() async {
    String url = Secret.url.getRequest.notification + '?id=' + studentId;

    try {
      final responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);

      if (responseData.statusCode == 200) {
        return jsonDecode(responseData.body);
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode}");
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
