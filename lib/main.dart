import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Paint.enableDithering = true;

  runApp(Application(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
