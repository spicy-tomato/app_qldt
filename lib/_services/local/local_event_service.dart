import 'package:app_qldt/_models/event_model.dart';
import 'package:app_qldt/_models/event_schedule_model.dart';
import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_models/schedule_model.dart';
import 'package:app_qldt/_services/api/api_event_service.dart';
import 'package:app_qldt/_services/controller/event_service_controller.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:flutter/widgets.dart';

/// This class used for saving data about events (or schedules)
/// into local storage
///
class LocalEventService extends LocalService {
  //  For schedule
  List<UserEventModel> scheduleData = [];

  List<UserEventModel> eventData = [];

  //  For calendar
  Map<DateTime, List<UserEventModel>> calendarData = {};

  /// Constructs a [LocalEventService] instance with user's ID account
  ///
  LocalEventService({DatabaseProvider? databaseProvider}) : super(databaseProvider);

  @override
  ServiceController<LocalService, ApiEventService> get serviceController =>
      controller as EventServiceController;

  /// Refresh events data
  ///
  /// 1. Get request raw schedules data from back-end by using [_eventService]
  /// 2. If data is received successfully, then:
  ///   2.1. Remove saved data from local database, by calling [_remove].
  ///   2.2. Save new data to database, by calling [_save].
  /// 3. Get data from local database, by calling [_loadCalendarData].
  /// 4. Return data.
  ///
  Future<void> saveNewData(List<ScheduleModel> newData) async {
    debugPrint('Event service: Updating new data');

    await _remove();
    await _save(newData);

    // await _loadCalendarData();
    await _loadScheduleData();
    await _loadEventData();
  }

  Future<void> updateVersion(int newVersion) async {
    await databaseProvider.dataVersion.updateScheduleVersion(newVersion);
  }

  Future<void> loadOldData() async {
    // await _loadCalendarData();
    await _loadScheduleData();
    await _loadEventData();
  }

  Future<void> _loadScheduleData() async {
    scheduleData.clear();

    List<Map<String, dynamic>> rawData = await databaseProvider.schedule.all;

    scheduleData =
        List.generate(rawData.length, (index) => UserEventModel.fromScheduleMap(rawData[index]));
  }

  Future<void> loadEvents() async {
    await _loadEventData();
  }

  Future<void> _loadEventData() async {
    eventData.clear();

    List<Map<String, dynamic>> rawData = await databaseProvider.event.all;

    eventData = List.generate(rawData.length, (index) => UserEventModel.fromMap(rawData[index]));
  }

  Future<int?> saveNewEvent(UserEventModel event) async {
    debugPrint('Adding event: $event');
    return await databaseProvider.event.insert(event.toMap());
  }

  Future<void> saveModifiedEvent(EventModel event) async {
    debugPrint('Modifying schedule: $event');
    await databaseProvider.event.update(event.toMap());
  }

  Future<void> saveModifiedSchedule(EventScheduleModel event) async {
    debugPrint('Modifying schedule: $event');
    await databaseProvider.eventSchedule.update(event.toMap());
  }

  Future<void> saveAllModifiedScheduleWithName(String name, EventScheduleModel event) async {
    debugPrint('Modifying all schedules with name $name: $event');
    await databaseProvider.eventSchedule.updateWithName(name, event.toMap());
  }

  Future<void> deleteEvent(int id) async {
    debugPrint('Deleting schedule has id: $id');
    await databaseProvider.event.delete(id);
  }

  Future<void> delete() async {
    await _remove();
  }

  /// Save schedule data to local database
  ///
  Future<void> _save(List<ScheduleModel> rawData) async {
    await databaseProvider.schedule.insert(rawData);
  }

  /// Remove schedule data from local database
  ///
  Future<void> _remove() async {
    await databaseProvider.schedule.delete();
  }

  /// Get schedule data from local database
  ///
  /// 1. Get raw schedule data from local database.
  /// 2. Parse raw data to [Map<DateTime, List<UserEvent>>].
  /// 3. Return parsed data.
  ///
// Future<void> _loadCalendarData() async {
//   List<Map<String, dynamic>> rawData = await databaseProvider.schedule.all;
//   Map<DateTime, List<UserEventModel>> data = _parseToStandardStructure(rawData);
//   calendarData = data;
// }

  /// Parse data from [List<Map<String, dynamic>>?]
  ///              to [Map<DateTime, List<UserEvent>>]
  ///
  /// 1. If input data is null, then return new empty map.
  /// 2. Generate [List<Schedule>] from input data, called [rawData].
  /// 3. Create new map to save result data, called [events].
  /// 4. For each [ScheduleModel] instance, called [schedule] in [rawData]:
  ///   4.1. If [events[schedule]] is null, then add new key-value pair, with
  ///        key is [schedule.daySchedules], and value is empty array []
  ///   4.2. Add new [UserEventModel] instance to [events[schedule.daySchedules]].
  /// 5. Return [events].
  ///
// Map<DateTime, List<UserEventModel>> _parseToStandardStructure(List<Map<String, dynamic>>? maps) {
//   if (maps == null) {
//     return new Map();
//   }
//
//   List<ScheduleModel> rawData = List.generate(
//     maps.length,
//     (index) => ScheduleModel.fromMap(maps[index]),
//   );
//
//   Map<DateTime, List<UserEventModel>> events = new Map();
//
//   for (var schedule in rawData) {
//     if (events[schedule.daySchedules] == null) {
//       events[schedule.daySchedules] = [];
//     }
//
//     UserEventModel event = UserEventModel.fromSchedule(
//       schedule,
//       colorMap[schedule.idModuleClass],
//     );
//
//     events[schedule.daySchedules]!.add(event);
//   }
//
//   return events;
// }
}
