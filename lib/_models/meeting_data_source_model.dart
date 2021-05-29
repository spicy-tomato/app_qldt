import 'dart:ui';

import 'package:app_qldt/_models/user_event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserDataSourceModel extends CalendarDataSource {
  UserDataSourceModel(List<UserEventModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].visualizeName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].backgroundColor;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
