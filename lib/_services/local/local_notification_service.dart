import 'package:app_qldt/_models/app_notification_model.dart';
import 'package:app_qldt/_models/receive_notification_model.dart';
import 'package:app_qldt/_models/sender_model.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_services/web/notification_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';

class LocalNotificationService extends LocalService {
  late final NotificationService _notificationService;

  List notificationData = [];

  LocalNotificationService({
    DatabaseProvider? databaseProvider,
    required String idUser,
    required String idAccount,
  })  : _notificationService = NotificationService(
          idStudent: idUser,
          idAccount: idAccount,
          localVersion: databaseProvider!.dataVersion.schedule,
        ),
        super(databaseProvider);

  Future<List> refresh() async {
    AppNotificationModel? data = await _notificationService.getNotification();

    if (data != null && databaseProvider.dataVersion.notification < _notificationService.localVersion) {
      print('Notification service: Updating new data');

      List<ReceiveNotificationModel> notifications = data.notification;
      List<SenderModel> senders = data.sender;

      await _removeNotification();
      await _saveNotification(notifications);

      await _removeSender();
      await _saveSender(senders);

      await _updateVersion();
    }

    notificationData = await getFromDb();

    return this.notificationData;
  }

  //#region notification
  Future<void> _removeNotification() async {
    await databaseProvider.notification.delete();
  }

  Future<void> _saveNotification(List<ReceiveNotificationModel> rawData) async {
    for (var row in rawData) {
      await databaseProvider.notification.insert(row.toMap());
    }
  }
  //#endregion

  //#region sender
  Future<void> _removeSender() async {
    await databaseProvider.sender.delete();
  }

  Future<void> _saveSender(List<SenderModel> rawData) async {
    for (var row in rawData) {
      await databaseProvider.sender.insert(row.toMap());
    }
  }
  //#endregion

  Future<void> _updateVersion() async {
    await databaseProvider.dataVersion.setNotificationVersion(_notificationService.localVersion);
  }

  Future<List> getFromDb() async {
    final rawData = await databaseProvider.notification.all;

    return rawData.map((data) {
      return UserNotificationModel.fromMap(data);
    }).toList();
  }
}
