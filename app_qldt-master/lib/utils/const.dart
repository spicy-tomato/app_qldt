import 'package:flutter/material.dart';

class Const {
  static Color primaryColor = Color(0xff0779e4);

  // Interface
  static Color interfaceBackgroundColor = Color(0xeef6f5f5);

  // Top bar
  static double topBarHeightRatio = 0.20;
  static Color topBarBackgroundColor = primaryColor;
  static Color topBarTextColor = Colors.white;
  static double topBarFontSize = 25;
  static double topBarIconSize = 40;

  // Side bar
  static Color sideBarBackgroundColor = primaryColor;
  static double sideBarIconSize = 40;

  // Content
  static double contentTopPaddingRatio = 0.155;
  static double contentLeftPaddingRatio = 0.035;
  static double contentRightPaddingRatio = contentLeftPaddingRatio;
  static BorderRadius topBarBorderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  );

  // Items
  static BorderRadius itemBorderRadius = BorderRadius.all(Radius.circular(15));
  static Color itemBackgroundColor = Colors.white;

  // Calendar
  static Color calendarTodayBackgroundColor = primaryColor;
  static Color calendarOutsideTodayBackgroundColor = Color(0xff77d8d8);
  static Color calendarSelectedBackgroundColor = Color(0xffff5722);
  static Color calendarOutsideDayBackgroundColor =
  calendarTextColor.withOpacity(0.4);
  static Color calendarWeekendBackgroundColor = calendarSelectedBackgroundColor;
  static Color calendarMarkerColor = Color(0xff4cbbb9);
  static Color calendarOutsideMarkerColor = calendarMarkerColor.withOpacity(
      0.4);

  static Color calendarTextColor = topBarBackgroundColor;
  static Color calendarTodayTextColor = Colors.white;
  static Color calendarSelectedDayTextColor = Colors.white;
  static Color calendarWeekdayOfWeek = topBarBackgroundColor;
  static Color calendarWeekendOfWeek = calendarSelectedBackgroundColor;

  static double calendarDayFontSize = 17;

  static double calendarHeaderMarginBottom = 10;
  static double calendarDayWidth = 20;
  static double calendarDayHeight = calendarDayWidth;

  static Alignment calendarMarkerAlignment = Alignment(0, 0.8);


}
