import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:app_qldt/_models/notification.dart';

class NotificationService {
  static final _timeout = 5;
  static final _baseUrl =
      'http://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/notification.php?ID_Student=';

  final String studentId;

  NotificationService(this.studentId);

  Future<List<UserNotification>?> getNotification(
    String studentId,
  ) async {
    try {
      List? data = await _fetchData();

      if (data != null) {
        List<UserNotification> list = data as List<UserNotification>;
        return list;
      }

      return null;
    } on Exception catch (_) {
      throw Exception('Cannot parse');
    }
  }

  Future<List?> _fetchData() async {
    String url = _baseUrl + studentId;

    try {
      final responseData =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: _timeout));

      if (responseData.statusCode == 200) {
        List data = jsonDecode(responseData.body) as List;
        List<UserNotification> listModel = [];

        for (var element in data) {
          listModel.add(UserNotification.fromJson(element));
        }

        return listModel;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode}");
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e');
    } on SocketException catch (e) {
      print('Socket error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }

    return null;
  }
}
