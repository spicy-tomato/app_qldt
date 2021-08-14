import 'package:app_qldt/config/theme/theme.dart';
import 'package:app_qldt/models/config/app_theme.dart';

enum AppTheme {
  dream,
  hope,
}

extension AppThemeExtension on AppTheme {
  AppThemeModel get data => appThemeData[this]!;
}
