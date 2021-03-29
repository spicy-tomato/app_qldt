import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  static Future<void> initialise() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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

  static Future<void> setupFirebaseMessagingBackground() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');
  }

  static Future<String?> getToken() async {
    print('Getting token');
    try {
      return await FirebaseMessaging.instance.getToken();
    } on Exception catch (e) {
      print(e);
    }
  }
}
