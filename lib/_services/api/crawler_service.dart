import 'dart:convert';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler_model.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CrawlerService {
  final ApiUrl apiUrl;

  CrawlerService(this.apiUrl);

  Future<CrawlerStatus> updatePassword(UpdatePasswordCrawlerModel crawler) async {
    http.Response response;
    String url = apiUrl.post.updatePasswordCrawler;
    String body = jsonEncode(crawler);

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromStatusCode(response.statusCode);
    } on Exception catch (e) {
      debugPrint('Error: $e in Crawler service - Update password');
      return CrawlerStatus.serverError;
    }
  }

  Future<CrawlerStatus> crawlScore(ScoreCrawlerModel crawler) async {
    String url = apiUrl.post.scoreCrawler;
    String body = jsonEncode(crawler);
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
    String url = apiUrl.post.examScheduleCrawler;
    String body = jsonEncode(crawler);
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
