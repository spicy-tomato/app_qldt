import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FirebaseRepository();

  Future initialise() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

  Future<String> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}
