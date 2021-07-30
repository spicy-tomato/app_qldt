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

  /// Guest
  String get guestAuthentication => host.guestBase + 'authenticate.php';

  String get guestUpsertToken => host.guestBase + 'upsert_token.php';

  String get guestUpdatePasswordCrawler => host.guestBase + 'update_qldt_password.php';

  String get guestScoreCrawler => host.guestCrawlBase + 'crawl_score.php';

  String get guestExamScheduleCrawler => host.guestCrawlBase + 'crawl_exam_schedule.php';
}
