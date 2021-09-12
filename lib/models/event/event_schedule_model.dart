import 'package:app_qldt/enums/plan/plan_enum.dart';
import 'package:app_qldt/models/event/user_event_model.dart';

class EventScheduleModel extends UserEventModel {
  EventScheduleModel({
    required int id,
    required PlanColors color,
    required String description,
    required String name,
    required String location,
    required String people,
  }) : super(
    id: id,
    eventName: name,
    color: color,
    location: location,
    description: description,
    type: EventType.schedule,
    people: people,
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
