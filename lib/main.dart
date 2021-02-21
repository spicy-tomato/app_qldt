// import 'package:app_qldt/screens/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'screens/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        // '/': (context) => FirebaseScreen(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''),
      ],
    ),
  );
}
