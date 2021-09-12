import 'package:app_qldt/config/config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app.dart';
import 'widgets/wrapper/app_mode.dart';

Future<void> main() async {
  await initializeApp();

  runApp(
    Phoenix(
      child: AppModeWidget(
        mode: AppConfig.mode,
        child: Application(),
      ),
    ),
  );
}
