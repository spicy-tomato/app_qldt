import 'dart:ui';

import 'package:app_qldt/_models/schedule_model.dart';

class UserEventModel {
  final String eventName;
  final String? location;
  final Color backgroundColor;
  late final String visualizeName;
  late final DateTime? from;
  late final DateTime? to;
  late final bool isAllDay;

  UserEventModel({
    required this.eventName,
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

    visualizeName = _getShortenClassName(this.eventName);
  }

  factory UserEventModel.fromSchedule(ScheduleModel schedule, [int? color]) {
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

    return UserEventModel(
      from: curr,
      eventName: schedule.moduleClassName,
      location: schedule.idRoom,
      backgroundColor: Color(color ?? 0xff0f8644),
    );
  }

  static String _getShortenClassName(String? string) {
    if (string == null){
      return '';
    }

    List<String> listSplitByWhiteSpace = string.split(' ');
    String oldStr = listSplitByWhiteSpace[listSplitByWhiteSpace.length - 2];
    List<String> strArr = oldStr.split('-');

    strArr.removeLast();
    strArr.removeLast();

    String newStr = strArr.join('-');
    newStr = string.replaceAll(oldStr, newStr);

    int indexOfOpenBrace = newStr.lastIndexOf('(');
    int indexOfCloseBrace = newStr.lastIndexOf(')');

    newStr = newStr.substring(0, indexOfOpenBrace) + newStr.substring(indexOfOpenBrace+1, indexOfCloseBrace);

    return newStr;
  }

  @override
  String toString() {
    return 'UserEvent{time: $from, name: $eventName, location: $location}';
  }
}
