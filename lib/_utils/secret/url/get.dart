import 'package:app_qldt/_utils/secret/url/base.dart';

class GetRequest {
  final Host host;

  const GetRequest(this.host);

  String get schedule => host.base + 'get_schedule.php';

  String get notification => host.base + 'get_notification.php';

  String get score => host.base + 'get_score.php';

  String get examSchedule => host.base + 'get_exam_schedule.php';

  String get version => host.base + 'get_data_version.php';
}
