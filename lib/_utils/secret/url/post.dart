import 'base.dart';

class PostRequest {
  final Host host;

  const PostRequest(this.host);

  String get authentication => host.base + 'authenticate.php';

  String get upsertToken => host.base + 'upsert_token.php';

  String get updatePasswordCrawler => host.base + 'update_qldt_password.php';

  String get scoreCrawler => host.externalBase + 'crawl_score.php';

  String get examScheduleCrawler => host.externalBase + 'crawl_exam_schedule.php';
}
