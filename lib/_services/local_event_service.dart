import 'package:app_qldt/_models/event.dart';
import 'package:app_qldt/_models/schedule.dart';

import 'database_provider.dart';
import 'event_service.dart';

class LocalEventService {
  final String studentId;
  late final EventService _eventService;
  late Map<DateTime, List<UserEvent>> eventsData;

  LocalEventService(this.studentId) {
    _eventService = EventService(studentId);
  }

  Future<Map<DateTime, List<UserEvent>>> refresh() async {
    List<Schedule>? rawData = await _eventService.getRawScheduleData();

    if (rawData != null) {
      await remove();
      await save(rawData);
    }

    eventsData = await getFromDb();

    return eventsData;
  }

  Future<void> save(List<Schedule> rawData) async {
    // print('Trying to save calendar');

    for (var row in rawData) {
      await DatabaseProvider.db.insertSchedule(row.toMap());
    }
  }

  Future<Map<DateTime, List<UserEvent>>> getFromDb() async {
    // print('Getting calendar');
    List<Map<String, dynamic>> rawData = await DatabaseProvider.db.schedule;
    Map<DateTime, List<UserEvent>> data = _parseToStandardStructure(rawData);
    return data;
  }

  Future<void> remove() async {
    await DatabaseProvider.db.deleteSchedule();
  }

  static Map<DateTime, List<UserEvent>> _parseToStandardStructure(
      List<Map<String, dynamic>>? maps) {
    if (maps == null) {
      return new Map();
    }

    List<Schedule> rawData = List.generate(
      maps.length,
      (index) => Schedule.fromMap(maps[index]),
    );

    Map<DateTime, List<UserEvent>> events = new Map();

    for (var schedule in rawData) {
      if (events[schedule.daySchedules] == null) {
        events[schedule.daySchedules] = [];
      }
      events[schedule.daySchedules]!.add(UserEvent.fromSchedule(schedule));
    }

    return events;
  }
}
