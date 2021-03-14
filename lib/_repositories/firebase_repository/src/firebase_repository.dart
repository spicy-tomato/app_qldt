import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialise() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
      print(message.notification);
    });
  }

  Future<String?> getToken() async {
    print('Getting token');
    try {
      return await FirebaseMessaging.instance.getToken();
    } on Exception catch (e) {
      print('Get token error: $e');
    }
  }
}
