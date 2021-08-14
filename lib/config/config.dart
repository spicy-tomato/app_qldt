import 'dart:ui';

import 'package:app_qldt/_utils/helper/pull_to_fresh_vn_delegate.dart';
import 'package:app_qldt/_utils/helper/sf_localization_vn_delegate.dart';
import 'package:app_qldt/enums/config/app_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

part 'locale/locale.dart';

part 'locale/delegate.dart';

part 'mode/mode.dart';

part 'setup/initialize_app.dart';

class AppConfig {
  static Iterable<Locale> get supportedLocales => _locales;

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates => _localizationsDelegates;

  static AppMode get mode => kReleaseMode ? AppMode.release : devMode;
}
