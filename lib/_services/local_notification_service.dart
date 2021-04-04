import 'package:app_qldt/_models/notification.dart';
import 'database_provider.dart';
import 'notification_service.dart';

class LocalNotificationService {
  final String studentId;
  late final NotificationService _notificationService;
  late List<dynamic> notificationData;

  LocalNotificationService(this.studentId) {
    _notificationService = NotificationService(studentId);
  }


  Future<List<dynamic>> refresh() async {
    List<UserNotification>? rawData = await _notificationService.getNotification(studentId);

    if (rawData != null) {
      await remove();
      await save(rawData);
    }

    // print('Refreshing notification');

    notificationData = await getFromDb();

    // print(notificationData);

    return this.notificationData;
  }

  static Future<void> save(List<UserNotification> rawData) async {
    // print('Trying to save notification');

    for (var row in rawData) {
      await DatabaseProvider.db.insertNotification(row.toMap());
    }
  }

  static Future<List<dynamic>> getFromDb() async {
    final rawData = await DatabaseProvider.db.notification;
    return rawData.map((data) => UserNotification.fromJson(data)).toList();
  }

  static Future<void> remove() async {
    await DatabaseProvider.db.deleteNotification();
  }
}
