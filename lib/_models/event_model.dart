import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/plan/plan.dart';

class EventModel extends UserEventModel {
  EventModel({
    int? id,
    required String eventName,
    required PlanColors color,
    required String location,
    required String description,
    required DateTime from,
    required DateTime to,
    required bool isAllDay,
    required String people,
  }) : super(
          id: id ?? -1,
          eventName: eventName,
          color: color,
          location: location,
          description: description,
          type: EventType.event,
          from: from,
          to: to,
          isAllDay: isAllDay,
          people: people,
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
      'people': people,
    };
  }
}
