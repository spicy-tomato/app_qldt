import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/plan/plan.dart';

class EventScheduleModel extends UserEventModel {
  EventScheduleModel({
    required int id,
    required PlanColors color,
    required String description,
    required String name,
    required String location,
  }) : super(
    id: id,
    eventName: name,
    color: color,
    location: location,
    description: description,
    type: EventType.schedule,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id_schedule': id,
      'color': color.color.value,
      'description': description,
    };
  }
}
