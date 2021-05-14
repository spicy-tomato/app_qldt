import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:http/http.dart' as http;

import 'package:app_qldt/_utils/secret/secret.dart';

class ScoreService {
  final String userId;

  ScoreService(this.userId);

  Future<List<Score>?> getScore() async {
    try {
      return await _fetchData();
    } on Exception catch (_) {
      throw Exception('Cannot parse date');
    }
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
  Future<List<Score>?> _fetchData() async {
    String url = Secret.url.getRequest.score + '?id=' + userId;

    try {
      final responseData = await http.get(Uri.parse(url)).timeout(Const.requestTimeout);

      if (responseData.statusCode == 200) {
        List data = jsonDecode(responseData.body) as List;
        List<Score> listModel = [];

        for (var element in data) {
          listModel.add(Score.fromJson(element));
        }

        return listModel;
      } else {
        print("Cannot GET. Response status code: ${responseData.statusCode}");
        return null;
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e at Score service');
    } on SocketException catch (e) {
      print('Socket error: $e at Score service');
    } on Error catch (e) {
      print('General Error: $e at Score service');
    }

    return null;
  }
}
