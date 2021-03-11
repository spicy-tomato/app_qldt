import 'package:app_qldt/_models/schedule.dart';
import 'database_provider.dart';
import 'schedule_service.dart';

class LocalScheduleService {
  final String studentId;
  late final ScheduleService _scheduleService;
  late Map<DateTime, List<dynamic>> schedulesData;

  LocalScheduleService(this.studentId){
    _scheduleService = new ScheduleService(studentId);
  }

  Future<Map<DateTime, List<dynamic>>> refresh() async{
    List<Schedule>? rawData = await _scheduleService.getRawScheduleData();

    if (rawData != null) {
      await remove();
      await save(rawData);
    }

    schedulesData = await getFromDb();
    return schedulesData;
  }

  Future<void> save(List<Schedule> rawData) async {
    // print('Trying to save calendar');

    for (var row in rawData){
      await DatabaseProvider.db.insertSchedule(row.toMap());
    }
  }

  Future<Map<DateTime, List<dynamic>>> getFromDb() async {
    // print('Getting calendar');
    List<Map<String, dynamic>> rawData = await DatabaseProvider.db.schedule;
    Map<DateTime, List> data = _parseToStandardStructure(rawData);
    return data;
  }

  Future<void> remove() async {
    // print('Trying to remove saved calendar');
    await DatabaseProvider.db.deleteSchedule();
  }

  static Map<DateTime, List> _parseToStandardStructure(
      List<Map<String, dynamic>>? maps) {
    if (maps == null) {
      return new Map();
    }

    List<Schedule> rawData = List.generate(
      maps.length,
          (index) => Schedule.fromMap(maps[index]),
    );

    Map<DateTime, List> events = new Map();

    for (var schedule in rawData){
      if (events[schedule.daySchedules] == null) {
        events[schedule.daySchedules] = [];
      }
      events[schedule.daySchedules]!.add(schedule);
    }

    return events;
  }
}
