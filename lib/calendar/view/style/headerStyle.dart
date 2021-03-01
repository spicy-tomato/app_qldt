import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
