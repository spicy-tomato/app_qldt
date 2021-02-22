import 'package:app_qldt/screens/firebase/firebase.dart';
import 'package:app_qldt/screens/home/local_widgets/calendar.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    final String studentId =
        ModalRoute.of(context).settings.arguments as String;

    final firebase = Firebase(_firebaseMessaging);
    firebase.initialise();

    return Interface(
      title: 'Trang chủ',
      child: Calendar(
        studentId: studentId,
        firebase: firebase,
      ),
    );
  }
}
