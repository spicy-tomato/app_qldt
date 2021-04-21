import 'dart:ui';

import 'package:app_qldt/_models/schedule.dart';

class UserEvent {
  final String name;
  late final DateTime? from;
  late final DateTime? to;
  final String? location;
  final Color backgroundColor;
  late final bool isAllDay;

  UserEvent({
    required this.name,
    DateTime? from,
    DateTime? to,
    this.location,
    required this.backgroundColor,
    bool? isAllDay,
  }) {
    if (from != null) {
      this.from = from;
      this.to = to ?? from.add(Duration(hours: 2, minutes: 25));
    }

    this.isAllDay = isAllDay == null ? false : true;
  }

  factory UserEvent.fromSchedule(Schedule schedule, [int? color]) {
    DateTime curr = schedule.daySchedules;
    int hour, minute = 0;

    switch (schedule.shiftSchedules) {
      case 1:
        hour = 7;
        break;

      case 2:
        hour = 9;
        minute = 35;
        break;

      case 3:
        hour = 13;
        break;

      case 4:
        hour = 15;
        minute = 35;
        break;

      default:
        hour = 19;
        break;
    }

    curr = DateTime(curr.year, curr.month, curr.day, hour, minute);

    return UserEvent(
      from: curr,
      name: schedule.moduleName,
      location: schedule.idRoom,
      backgroundColor: Color(color ?? 0xff0f8644),
    );
  }

  @override
  String toString() {
    return 'UserEvent{time: $from, name: $name, location: $location}';
  }
}
