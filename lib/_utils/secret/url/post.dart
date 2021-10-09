import 'base.dart';

class PostRequest {
  final Host host;

  const PostRequest(this.host);

  /// User
  String get authentication => host.base + 'auth/authenticate';

  String get upsertToken => host.base + 'device/upsert-device-token';

  String get updatePasswordCrawler => host.base + 'account/update-qldt-password';

  String get scoreCrawler => host.crawlBase + 'module-score/all';

  String get examScheduleCrawler => host.crawlBase + 'exam_schedule/all';
}
