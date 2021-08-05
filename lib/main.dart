import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

// import '_models/secret.dart';

import '_widgets/model/app_mode.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  // var _clientId = new ClientId(Secret.getId(), '');
  // const _scopes = const [];

  Paint.enableDithering = true;

  AppMode devMode = AppMode.debug;
  AppMode mode = kReleaseMode ? AppMode.release : devMode;

  debugPrint('Running in mode $mode');

  runApp(
    Phoenix(
      child: AppModeWidget(
        mode: mode,
        child: Application(),
      ),
    ),
  );
}
