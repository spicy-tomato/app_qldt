import 'package:app_qldt/_models/schedule_model.dart';
import 'package:app_qldt/plan/bloc/enum/enum.dart';
import 'package:intl/intl.dart';
import 'package:app_qldt/plan/bloc/enum/color.dart';

import 'exam_schedule_model.dart';

enum EventType {
  schedule,
  exam,
  event,
}

class UserEventModel {
  final int id;
  final EventType type;
  late String eventName;
  late String? location;
  late String? description;
  late PlanColors color;
  late DateTime? from;
  late DateTime? to;
  late bool isAllDay;

  UserEventModel({
    required this.eventName,
    required this.type,
    required this.id,
    this.location,
    this.description,
    PlanColors? color,
    DateTime? from,
    DateTime? to,
    bool? isAllDay,
  }) {
    if (from != null) {
      this.from = from;
      this.to = to ?? from.add(Duration(hours: 2, minutes: 25));
    } else {
      this.from = this.to = null;
    }

    this.isAllDay = isAllDay ?? false;
    this.color = color ?? PlanColors.defaultColor;

    eventName = type == EventType.schedule
        ? _getShortenClassName(eventName)
        : eventName == ''
            ? '(Chưa có tiêu đề)'
            : eventName;
  }

  factory UserEventModel.fromSchedule(ScheduleModel schedule, [int? color]) {
    DateTime curr = schedule.daySchedules.withShift(schedule.shiftSchedules);

    return UserEventModel(
      id: schedule.id,
      type: EventType.schedule,
      from: curr,
      eventName: schedule.moduleClassName,
      location: schedule.idRoom,
      isAllDay: false,
    );
  }

  static String _getShortenClassName(String? string) {
    if (string == null) {
      return '';
    }

    try {
      List<String> listSplitByWhiteSpace = string.split(' ');
      String oldStr = listSplitByWhiteSpace[listSplitByWhiteSpace.length - 2];
      List<String> strArr = oldStr.split('-');

      strArr.removeLast();
      strArr.removeLast();

      String newStr = strArr.join('-');
      newStr = string.replaceAll(oldStr, newStr);

      int indexOfOpenBrace = newStr.lastIndexOf('(');
      int indexOfCloseBrace = newStr.lastIndexOf(')');

      newStr = newStr.substring(0, indexOfOpenBrace) +
          newStr.substring(indexOfOpenBrace + 1, indexOfCloseBrace);

      return newStr;
    } on RangeError catch (_) {
      return string;
    }
  }

  factory UserEventModel.fromExamScheduleModel(ExamScheduleModel examScheduleModel) {
    String timeStr = RegExp(r'(\d{2}:\d{2})').firstMatch(examScheduleModel.timeStart)!.group(0)!;
    int hour = int.parse(timeStr.split(':')[0]);
    int minute = int.parse(timeStr.split(':')[1]);

    DateTime from = DateFormat('d-M-yyyy').parse(examScheduleModel.dateStart);
    from = from.add(Duration(hours: hour, minutes: minute));

    DateTime to = from.add(Duration(minutes: examScheduleModel.credit * 45));

    return UserEventModel(
      id: -1,
      type: EventType.exam,
      eventName: 'Thi ' + examScheduleModel.moduleName,
      location: examScheduleModel.room,
      from: from,
      to: to,
      color: PlanColors.tomato,
      description: 'Số báo danh: ${examScheduleModel.identificationNumber}',
    );
  }

  factory UserEventModel.fromMap(Map<String, dynamic> map) {
    return UserEventModel(
      id: map['id_event'],
      eventName: map['name'],
      color: map['color'] != null ? (map['color'] as int).toPlanColors() : null,
      location: map['location'],
      description: map['description'],
      from: DateTime.parse(map['time_start']),
      to: DateTime.parse(map['time_end']),
      isAllDay: map['is_all_day'] == 1,
      type: EventType.event,
    );
  }

  factory UserEventModel.fromScheduleMap(Map<String, dynamic> map) {
    DateTime curr = DateTime.parse(map['day_schedules']).withShift(map['shift_schedules'] as int);

    return UserEventModel(
      id: map['id_schedule'],
      eventName: map['module_class_name'],
      type: EventType.schedule,
      from: curr,
      color: map['color'] != null ? (map['color'] as int).toPlanColors() : null,
      location: map['id_room'],
      description: map['description'],
      isAllDay: map['is_all_day'] != null ? (map['is_all_day'] as int) == 1 : false,
    );
  }

  Map<String, dynamic> toMap() {
    return Map();
  }

  @override
  String toString() {
    return 'UserEvent{time: $from, name: $eventName, location: $location}';
  }
}

extension DateTimeWithShift on DateTime {
  DateTime withShift(int shift) {
    int hour, minute = 0;

    switch (shift) {
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

    return DateTime(this.year, this.month, this.day, hour, minute);
  }
}
