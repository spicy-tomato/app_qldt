import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';
import 'package:app_qldt/utils/const.dart';

HeaderStyle headerStyle() {
  return const HeaderStyle(
    centerHeaderTitle: true,
    formatButtonVisible: false,
    headerMargin: EdgeInsets.only(bottom: Const.calendarHeaderMarginBottom),
    titleTextStyle: const TextStyle(
      fontSize: Const.calendarDayFontSize,
      color: Const.calendarTextColor,
    ),
  );
}
