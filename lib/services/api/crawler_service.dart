import 'dart:convert';

import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/enums/crawl/crawler_status.dart';
import 'package:app_qldt/models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/models/crawler/score_crawler_model.dart';
import 'package:app_qldt/models/crawler/update_password_crawler_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CrawlerService {
  final ApiUrl apiUrl;

  CrawlerService(this.apiUrl);

  Future<CrawlerStatus> updatePassword(UpdatePasswordCrawlerModel crawler) async {
    http.Response response;
    final String url = apiUrl.post.updatePasswordCrawler;
    final String body = jsonEncode(crawler);

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromStatusCode(response.statusCode);
    } on Exception catch (e) {
      debugPrint('Error: $e in Crawler service - Update password');
      return CrawlerStatus.serverError;
    }
  }

  Future<CrawlerStatus> crawlScore(ScoreCrawlerModel crawler) async {
    final String url = apiUrl.post.scoreCrawler;
    final String body = jsonEncode(crawler);
    http.Response response;

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromStatusCode(response.statusCode);
    } on Exception catch (e) {
      debugPrint('Error: $e in Crawler service - Crawl score');
      return CrawlerStatus.serverError;
    }
  }

  Future<CrawlerStatus> crawlExamSchedule(ExamScheduleCrawlerModel crawler) async {
    final String url = apiUrl.post.examScheduleCrawler;
    final String body = jsonEncode(crawler);
    http.Response response;

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromStatusCode(response.statusCode);
    } on Exception catch (e) {
      debugPrint('Error: $e in Crawler service - Crawl exam schedule');
      return CrawlerStatus.serverError;
    }
  }
}
