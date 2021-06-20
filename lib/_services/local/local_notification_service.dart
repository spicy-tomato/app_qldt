import 'package:app_qldt/_models/receive_notification_model.dart';
import 'package:app_qldt/_models/sender_model.dart';
import 'package:app_qldt/_models/user_notification_model.dart';
import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/controller/notification_service_controller.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';

class LocalNotificationService extends LocalService {
  List<UserNotificationModel> notificationData = [];

  LocalNotificationService({DatabaseProvider? databaseProvider}) : super(databaseProvider);

  @override
  ServiceController<LocalService, ApiService> get serviceController =>
      controller as NotificationServiceController;

  Future<List> saveNewData(
    List<SenderModel> senderList,
    List<ReceiveNotificationModel> notificationList,
  ) async {
    print('Notification service: Updating new data');

    await _removeNotification();
    await _saveNotification(notificationList);

    await _removeSender();
    await _saveSender(senderList);

    await _loadFromDb();

    return this.notificationData;
  }

  Future<void> updateVersion(int newVersion) async {
    await databaseProvider.dataVersion.setNotificationVersion(newVersion);
  }

  Future<void> loadOldData() async {
    await _loadFromDb();
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

  Future<void> _loadFromDb() async {
    final rawData = await databaseProvider.notification.all;

    notificationData = rawData.map((data) {
      return UserNotificationModel.fromMap(data);
    }).toList();
  }
}
