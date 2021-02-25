import 'package:app_qldt/screens/firebase/firebase.dart';
import 'package:app_qldt/screens/home/local_widgets/calendar.dart';
import 'package:app_qldt/services/autoLogin.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebase = Firebase(_firebaseMessaging);
    firebase.initialise();

    return Interface(
        title: 'Trang chủ',
        child: FutureBuilder(
          future: getSavedLoginInfo(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Calendar(
              studentId: snapshot.data,
              // firebaseRepository: firebase,
            );
          },
        ));
  }
}
