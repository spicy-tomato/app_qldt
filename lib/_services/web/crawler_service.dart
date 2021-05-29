import 'dart:convert';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler_model.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/secret.dart';
import 'package:http/http.dart' as http;

class CrawlerService {
  static Future<CrawlerStatus> updatePassword(UpdatePasswordCrawlerModel crawler) async {
    http.Response response;
    String url = Secret.url.postRequest.examScheduleCrawler;
    String body = jsonEncode(crawler);

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromString(jsonDecode(response.body));
    } on Exception catch (e) {
      print('Error: $e in Crawler service - Update password');
      return CrawlerStatus.failed;
    }
  }

  static Future<CrawlerStatus> crawlScore(ScoreCrawlerModel crawler) async {
    String url = Secret.url.postRequest.scoreCrawler;
    String body = jsonEncode(crawler);
    http.Response response;

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromString(jsonDecode(response.body));
    } on Exception catch (e) {
      print('Error: $e in Crawler service - Crawl score');
      return CrawlerStatus.failed;
    }
  }

  static Future<CrawlerStatus> crawlExamSchedule(ExamScheduleCrawlerModel crawler) async {
    String url = Secret.url.postRequest.examScheduleCrawler;
    String body = jsonEncode(crawler);
    http.Response response;

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromString(jsonDecode(response.body));
    } on Exception catch (e) {
      print('Error: $e in Crawler service - Crawl exam schedule');
      return CrawlerStatus.failed;
    }
  }
}
