part of '../config.dart';

enum AppLocale {
  vietnamese,
}

const map = {
  AppLocale.vietnamese: Locale('vi', '')
};

extension AppLocaleExtension on AppLocale {
  Locale get data => map[this]!;
}

final _locales = map.values;
