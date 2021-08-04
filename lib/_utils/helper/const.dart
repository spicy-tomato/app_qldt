import 'package:app_qldt/_models/screen.dart';
import 'package:flutter/material.dart';

class Const {
  static Duration get requestTimeout => const Duration(seconds: 20);
  static Duration get crawlerTimeout => const Duration(minutes: 5);

  static String get defaultPage => ScreenPage.home.string;

  static const Color primaryColor = Color(0xff0779e4);

  // Interface
  static const Color interfaceBackgroundColor = Color(0xeef6f5f5);

  // Top bar
  static const double topBarHeightRatio = 0.20;
  static const Color topBarBackgroundColor = primaryColor;
  static const Color topBarTextColor = Colors.white;
  static const double topBarFontSize = 25;
  static const double topBarIconSize = 40;

  // Side bar
  static const Color sideBarBackgroundColor = primaryColor;
  static const double sideBarIconSize = 40;
  static const double sideBarTileFontSize = 16;

  // Content
  static const double contentTopPaddingRatio = 0.155;
  static const double contentLeftPaddingRatio = 0.035;
  static const double contentRightPaddingRatio = contentLeftPaddingRatio;
  static const BorderRadius topBarBorderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  );

  // Items
  static const BorderRadius itemBorderRadius =
      BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15));
  static const Color itemBackgroundColor = Colors.white;

  // Calendar
  static const Color calendarTodayBackgroundColor = primaryColor;
  static const Color calendarOutsideTodayBackgroundColor = Color(0xff77d8d8);
  static const Color calendarSelectedBackgroundColor = Color(0xffff5722);
  static const Color calendarOutsideDayBackgroundColor =
      Color(0xff9cc9f4); // calendarTextColor.withOpacity(0.4);
  static const Color calendarWeekendBackgroundColor = calendarSelectedBackgroundColor;
  static const Color calendarOutsideWeekendBackgroundColor =
      Color(0xffffbca7); // calendarWeekendBackgroundColor.withOpacity(0.4);
  static const Color calendarMarkerColor = Color(0xff4cbbb9);
  static const Color calendarOutsideMarkerColor =
      Color(0xffb7e4e3); // calendarMarkerColor.withOpacity(0.4);

  static const Color calendarTextColor = topBarBackgroundColor;
  static const Color calendarTodayTextColor = Colors.white;
  static const Color calendarSelectedDayTextColor = Colors.white;
  static const Color calendarWeekdayOfWeek = topBarBackgroundColor;
  static const Color calendarWeekendOfWeek = calendarSelectedBackgroundColor;

  static const double calendarDayFontSize = 17;

  static const double calendarHeaderMarginBottom = 10;
  static const double calendarDayWidth = 20;
  static const double calendarDayHeight = calendarDayWidth;

  static const Alignment calendarMarkerAlignment = Alignment(0, 0.8);
}
