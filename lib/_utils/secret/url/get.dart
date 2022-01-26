import 'package:app_qldt/_utils/secret/url/base.dart';

class GetRequest {
  final Host host;

  const GetRequest(this.host);

  String get schedule => host.base + 'student/schedule';

  String get teacherSchedule => host.base + '';

  String get notification => host.base + 'student/notification';

  String get score => host.base + 'student/module-score';

  String get examSchedule => host.base + 'student/exam-schedule';

  String get version => host.base + '/student/data-version';
}
