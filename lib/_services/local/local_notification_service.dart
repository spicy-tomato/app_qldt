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
    List<SenderModel>? senderList,
    List<ReceiveNotificationModel>? notificationList,
    List<int>? deleteList,
  ) async {
    print('Notification service: Updating new data');

    await _saveNotification(notificationList);
    await _saveSender(senderList);
    await _deleteNotification(deleteList);

    await _loadFromDb();

    return notificationData;
  }

  Future<void> updateVersion(int newVersion) async {
    await databaseProvider.dataVersion.updateNotificationVersion(newVersion);
  }

  Future<void> loadOldData() async {
    await _loadFromDb();
  }

  Future<void> _saveNotification(List<ReceiveNotificationModel>? rawData) async {
    if (rawData != null) {
      await databaseProvider.notification.insert(rawData);
    }
  }

  Future<void> _saveSender(List<SenderModel>? rawData) async {
    if (rawData != null) {
      await databaseProvider.sender.insert(rawData);
    }
  }

  Future<void> _deleteNotification(List<int>? list) async {
    if (list != null) {
      await databaseProvider.notification.deleteRow(list);
    }
  }

  Future<void> _loadFromDb() async {
    final rawData = await databaseProvider.notification.all;

    notificationData = rawData.map((data) {
      return UserNotificationModel.fromMap(data);
    }).toList();
  }
}
