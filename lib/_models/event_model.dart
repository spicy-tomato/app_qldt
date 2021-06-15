import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/plan/plan.dart';

class EventModel extends UserEventModel {
  EventModel({
    required String eventName,
    required PlanColors color,
    required String location,
    required String description,
    required DateTime from,
    required DateTime to,
    required bool isAllDay,
  }) : super(
          id: -1,
          eventName: eventName,
          color: color,
          location: location,
          description: description,
          type: EventType.event,
          from: from,
          to: to,
          isAllDay: isAllDay,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': eventName,
      'color': color.color.value,
      'location': location,
      'description': description,
      'time_start': from!.toIso8601String(),
      'time_end': to!.toIso8601String(),
      'is_all_day': isAllDay ? 1 : 0,
    };
  }
}
