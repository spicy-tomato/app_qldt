import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// import '_models/secret.dart';
import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';

import '_widgets/model/app_mode.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // var _clientId = new ClientId(Secret.getId(), "");
  // const _scopes = const [];

  Paint.enableDithering = true;

  AppMode mode = AppMode.staging;

  print('Running in mode ${kReleaseMode ? AppMode.release : mode}');

  runApp(
    Phoenix(
      child: AppModeWidget(
        mode: kReleaseMode ? AppMode.release : mode,
        child: Application(
          authenticationRepository: AuthenticationRepository(),
          userRepository: UserRepository(),
        ),
      ),
    ),
  );
}
