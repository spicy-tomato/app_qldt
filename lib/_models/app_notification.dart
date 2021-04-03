import 'receive_notification.dart';
import 'sender.dart';

class AppNotification {
  List<ReceiveNotification> notification;
  List<Sender> sender;

  AppNotification(this.notification, this.sender);
}