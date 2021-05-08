import 'dart:ui';

import 'package:app_qldt/_models/user_event.dart';
import 'package:app_qldt/_models/schedule.dart';
import 'package:app_qldt/_utils/database/provider.dart';

import '../web/event_service.dart';

/// This class used for saving data about events (or schedules)
/// into local storage
///
class LocalEventService {
  final String? userId;
  late DatabaseProvider databaseProvider;
  final List<UserEvent> userEventList = [];

  Map<String, int> colorMap = Map();
  Map<DateTime, List<UserEvent>> eventsData = Map();

  late final EventService? _eventService;

  /// Constructs a [LocalEventService] instance with user's ID account
  ///
  LocalEventService({DatabaseProvider? databaseProvider, this.userId}) {
    this.databaseProvider = databaseProvider ?? DatabaseProvider();

    if (userId != null) {
      _eventService = EventService(userId!);
    }
  }

  /// Refresh events data
  ///
  /// 1. Get request raw schedules data from back-end by using [_eventService]
  /// 2. If data is received successfully, then:
  ///   2.1. Remove saved data from local database, by calling [_remove].
  ///   2.2. Save new data to database, by calling [_save].
  /// 3. Get data from local database, by calling [_getFromDb].
  /// 4. Return data.
  ///
  Future<void> refresh() async {
    List<Schedule>? rawData = await _eventService!.getRawScheduleData();

    if (rawData != null) {
      await _remove();
      await _save(rawData);
    }

    await _addColor();
    await _getColorMap();

    eventsData = await _getFromDb();
  }

  Future<void> updateColor(String idModuleClass, Color color) async {
    Map<String, dynamic> dataMap = new Map();
    dataMap[idModuleClass] = color.toString();

    await databaseProvider.colorEvent.updateColor(dataMap);
  }

  /// Save schedule data to local database
  ///
  Future<void> _save(List<Schedule> rawData) async {
    for (var row in rawData) {
      await databaseProvider.schedule.insert(row.toMap());
    }
  }

  /// Remove schedule data from local database
  ///
  Future<void> _remove() async {
    await databaseProvider.schedule.delete();
  }

  /// Update color of schedule from local database
  ///
  Future<void> _addColor() async {
    await databaseProvider.colorEvent.insertColorToNew(databaseProvider.schedule);
  }

  Future<void> _getColorMap() async {
    List<Map<String, dynamic>> colorMapList = await databaseProvider.colorEvent.map;

    if (colorMapList.isEmpty) {
      colorMap = new Map();
    } else {
      for (var map in colorMapList) {
        String key = map['id_module_class'];
        int value = int.parse(map['color']);

        colorMap[key] = value;
      }
    }
  }

  /// Get schedule data from local database
  ///
  /// 1. Get raw schedule data from local database.
  /// 2. Parse raw data to [Map<DateTime, List<UserEvent>>].
  /// 3. Return parsed data.
  ///
  Future<Map<DateTime, List<UserEvent>>> _getFromDb() async {
    List<Map<String, dynamic>> rawData = await databaseProvider.schedule.all;
    Map<DateTime, List<UserEvent>> data = _parseToStandardStructure(rawData);

    return data;
  }

  /// Parse data from [List<Map<String, dynamic>>?]
  ///              to [Map<DateTime, List<UserEvent>>]
  ///
  /// 1. If input data is null, then return new empty map.
  /// 2. Generate [List<Schedule>] from input data, called [rawData].
  /// 3. Create new map to save result data, called [events].
  /// 4. For each [Schedule] instance, called [schedule] in [rawData]:
  ///   4.1. If [events[schedule]] is null, then add new key-value pair, with
  ///        key is [schedule.daySchedules], and value is empty array []
  ///   4.2. Add new [UserEvent] instance to [events[schedule.daySchedules]].
  /// 5. Return [events].
  ///
  Map<DateTime, List<UserEvent>> _parseToStandardStructure(List<Map<String, dynamic>>? maps) {
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

      UserEvent event = UserEvent.fromSchedule(
        schedule,
        colorMap[schedule.idModuleClass],
      );

      events[schedule.daySchedules]!.add(event);
    }

    return events;
  }

  void refreshUserEventList() {
    userEventList.clear();

    eventsData.forEach((_, mapValue) {
      mapValue.forEach((element) {
        userEventList.add(element);
      });
    });
  }

  Future<void> delete() async {
    await _remove();
  }

  static LocalEventService get instance => LocalEventService();
}
