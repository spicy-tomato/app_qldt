import 'package:app_qldt/_utils/secret/url/base.dart';

class GetRequest {
  const GetRequest();

  String get schedule => Host.base + 'get_schedule.php';

  String get notification => Host.base + 'notification.php';

  String get score => Host.base + 'get_score.php';
}
