import 'package:app_qldt/_models/app_notification_model.dart';
import 'package:app_qldt/_models/receive_notification_model.dart';
import 'package:app_qldt/_models/sender_model.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_services/web/notification_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';

class LocalNotificationService extends LocalService {
  late final NotificationService _notificationService;

  List<dynamic> notificationData = [];

  LocalNotificationService({DatabaseProvider? databaseProvider, required String userId})
      : _notificationService = NotificationService(userId),
        super(databaseProvider);

  Future<List<dynamic>> refresh() async {
    AppNotificationModel? data = await _notificationService.getNotification();

    if (data != null) {
      List<ReceiveNotificationModel> notifications = data.notification;
      List<SenderModel> senders = data.sender;

      await removeNotification();
      await saveNotification(notifications);

      await removeSender();
      await saveSender(senders);
    }

    notificationData = await getFromDb();

    return this.notificationData;
  }

  //#region notification
  Future<void> saveNotification(List<ReceiveNotificationModel> rawData) async {
    for (var row in rawData) {
      await databaseProvider.notification.insert(row.toMap());
    }
  }

  Future<void> removeNotification() async {
    await databaseProvider.notification.delete();
  }

  //#endregion

  //#region sender
  Future<void> saveSender(List<SenderModel> rawData) async {
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
      return UserNotificationModel.fromMap(data);
    }).toList();
  }
}
