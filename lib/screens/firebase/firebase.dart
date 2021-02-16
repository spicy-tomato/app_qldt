import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class Firebase {
  final FirebaseMessaging _firebaseMessaging;

  Firebase(this._firebaseMessaging);

  Future initialise() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    String token = await _firebaseMessaging.getToken();
    print('FirebaseMessaging token: $token');

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          // if (Platform.isAndroid) {
          //   notification = PushNotificationMessage(
          //     title: message['notification']['title'],
          //     body: message['notification']['body'],
          //   );
          // }
        }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
    });
  }
}

class FirebaseScreen extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Widget build(BuildContext context) {
    final firebase = Firebase(_firebaseMessaging);
    firebase.initialise();
    return Container();
  }
}

class PushNotificationMessage {
  final String title;
  final String body;

  PushNotificationMessage({
    @required this.title,
    @required this.body,
  });
}
