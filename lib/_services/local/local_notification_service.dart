import 'package:app_qldt/_models/app_notification.dart';
import 'package:app_qldt/_models/receive_notification.dart';
import 'package:app_qldt/_models/sender.dart';
import 'package:app_qldt/_models/user_notification.dart';
import 'package:app_qldt/_services/web/notification_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';

class LocalNotificationService {
  final String? userId;
  late DatabaseProvider databaseProvider;
  late final NotificationService _notificationService;

  List<dynamic> notificationData = [];

  LocalNotificationService({DatabaseProvider? databaseProvider, this.userId}) {
    this.databaseProvider = databaseProvider ?? DatabaseProvider();

    if (userId != null) {
      _notificationService = NotificationService(userId!);
    }
  }

  Future<List<dynamic>> refresh() async {
    AppNotification? data = await _notificationService.getNotification(userId!);

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
  Future<void> saveNotification(List<ReceiveNotification> rawData) async {
    for (var row in rawData) {
      await databaseProvider.notification.insert(row.toMap());
    }
  }

  Future<void> removeNotification() async {
    await databaseProvider.notification.delete();
  }

  //#endregion

  //#region sender
  Future<void> saveSender(List<Sender> rawData) async {
    for (var row in rawData) {
      await databaseProvider.sender.insert(row.toMap());
    }
  }

  Future<void> removeSender() async {
    await databaseProvider.sender.delete();
  }

  //#endregion

  Future<List<dynamic>> getFromDb() async {
    final rawData = await databaseProvider.notification.all;

    return rawData.map((data) {
      return UserNotification.fromMap(data);
    }).toList();
  }

  static LocalNotificationService get instance => LocalNotificationService();
}
