import 'dart:convert';

import 'package:app_qldt/_models/crawler/score_crawler.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/secret.dart';
import 'package:http/http.dart' as http;

enum CrawlerStatus {
  ok,
  failed,
  invalidPassword,
  unknown,
}

extension CrawlerStatusExtension on CrawlerStatus {
  static CrawlerStatus fromString(String string) {
    switch (string) {
      case 'OK':
        return CrawlerStatus.ok;

      case 'Unknown':
        return CrawlerStatus.unknown;

      case 'Invalid Password':
        return CrawlerStatus.invalidPassword;

      default:
        return CrawlerStatus.failed;
    }
  }

  bool get isOk => this == CrawlerStatus.ok;

  bool get isFailed => this == CrawlerStatus.failed;

  bool get isInvalidPassword => this == CrawlerStatus.invalidPassword;

  bool get isUnknown => this == CrawlerStatus.unknown;
}

class CrawlerService {
  static Future<CrawlerStatus> updatePassword(UpdatePasswordCrawler crawler) async {
    String url = Secret.url.postRequest.updatePasswordCrawler;
    String body = jsonEncode(crawler);
    http.Response response;

    try {
      response = await http.post(Uri.parse(url), body: body).timeout(Const.crawlerTimeout);
      return CrawlerStatusExtension.fromString(jsonDecode(response.body));
    } on Exception catch (e) {
      print('Error: $e in Crawler service - Update password');
      return CrawlerStatus.failed;
    }
  }

  static Future<CrawlerStatus> crawlScore(ScoreCrawler crawler) async {
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
}
