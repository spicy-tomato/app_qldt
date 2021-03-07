import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

DaysOfWeekStyle daysOfWeekStyle() {
  return const DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      fontSize: Const.calendarDayFontSize,
      color: Const.calendarWeekdayOfWeek,
    ),
    weekendStyle: TextStyle(
      fontSize: Const.calendarDayFontSize,
      color: Const.calendarWeekendOfWeek,
    ),
  );
}
