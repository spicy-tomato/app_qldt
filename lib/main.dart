import 'package:flutter/material.dart';

import 'package:app_qldt/repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/repositories/firebase_repository/src/firebase_repository.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseRepository.setupFirebaseMessagingBackground();

  runApp(Application(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}