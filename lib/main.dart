import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// import '_models/secret.dart';
import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // var _clientId = new ClientId(Secret.getId(), "");
  // const _scopes = const [];

  Paint.enableDithering = true;

  runApp(
    Phoenix(
      child: Application(
        authenticationRepository: AuthenticationRepository(),
        userRepository: UserRepository(),
      ),
    ),
  );
}
