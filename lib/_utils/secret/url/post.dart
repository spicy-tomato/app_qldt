import 'base.dart';

class PostRequest {
  final Host host;

  const PostRequest(this.host);

  /// User
  String get authentication => host.base + 'authenticate.php';

  String get upsertToken => host.base + 'upsert_token.php';

  String get updatePasswordCrawler => host.base + 'update_qldt_password.php';

  String get scoreCrawler => host.crawlBase + 'crawl_score.php';

  String get examScheduleCrawler => host.crawlBase + 'crawl_exam_schedule.php';
}
