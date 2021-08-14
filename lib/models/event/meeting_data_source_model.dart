import 'dart:ui';

import 'package:app_qldt/enums/plan/plan_enum.dart';
import 'package:app_qldt/models/event/user_event_model.dart';
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
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return (appointments![index].color as PlanColors).color;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
