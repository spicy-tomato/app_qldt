import 'base.dart';

class PostRequest {
  const PostRequest();

  String get authentication => Host.base + 'authenticate.php';

  String get upsertToken => Host.base + 'upsert_token.php';

  String get updatePasswordCrawler => Host.base + 'update_qldt_password.php';

  String get scoreCrawler => Host.externalBase + 'crawl_score.php';

  String get examScheduleCrawler => Host.externalBase + 'crawl_exam_schedule.php';
}
