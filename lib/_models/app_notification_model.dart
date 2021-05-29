import 'receive_notification_model.dart';
import 'sender_model.dart';

class AppNotificationModel {
  List<ReceiveNotificationModel> notification;
  List<SenderModel> sender;

  AppNotificationModel(this.notification, this.sender);
}