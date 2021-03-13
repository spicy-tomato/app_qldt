import 'package:app_qldt/_models/schedule.dart';

class UserEvent {
  final DateTime time;
  final String name;
  final String? location;

  UserEvent({required this.time, required this.name, this.location});

  factory UserEvent.fromSchedule(Schedule schedule) {
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
      time: curr,
      name: schedule.moduleName,
      location: schedule.idRoom,
    );
  }
}
