import 'package:app_qldt/_models/app_notification.dart';
import 'package:app_qldt/_models/receive_notification.dart';
import 'package:app_qldt/_models/sender.dart';
import 'package:app_qldt/_models/user_notification.dart';
import 'package:app_qldt/_services/web/notification_service.dart';
import 'package:app_qldt/_utils/database/database_provider.dart';

class LocalNotificationService {
  final String studentId;
  late final NotificationService _notificationService;
  late List<dynamic> notificationData;

  LocalNotificationService(this.studentId) {
    _notificationService = NotificationService(studentId);
  }

  Future<List<dynamic>> refresh() async {
    AppNotification? data = await _notificationService.getNotification(studentId);

    if (data != null) {
      List<ReceiveNotification> notifications = data.notification;
      List<Sender> senders = data.sender;

      await removeNotification();
      await saveNotification(notifications);

      await removeSender();
      await saveSender(senders);
    }

    notificationData = await getFromDb();

    return this.notificationData;
  }

  //#region notification
  static Future<void> saveNotification(List<ReceiveNotification> rawData) async {
    for (var row in rawData) {
      await DatabaseProvider.db.insertNotification(row.toMap());
    }
  }

  static Future<void> removeNotification() async {
    await DatabaseProvider.db.deleteNotification();
  }

  //#endregion

  //#region sender
  static Future<void> saveSender(List<Sender> rawData) async {
    for (var row in rawData) {
      await DatabaseProvider.db.insertSender(row.toMap());
    }
  }

  static Future<void> removeSender() async {
    await DatabaseProvider.db.deleteSender();
  }

  //#endregion

  static Future<List<dynamic>> getFromDb() async {
    final rawData = await DatabaseProvider.db.notification;
    return rawData.map((data) {
      return UserNotification.fromMap(data);
    }).toList();
  }

  static Future<void> delete() async {
    await removeNotification();
    await removeSender();
  }
}
