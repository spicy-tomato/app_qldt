import 'package:app_qldt/_models/schedule_model.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbSchedule extends TableModel {
  DbSchedule([Database? database]) : super(database);

  static String get tableName => 'schedule';

  static String get eventScheduleTable => 'event_schedule';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_schedule INTEGER PRIMARY KEY,'
      'id_module_class TEXT,'
      'module_class_name TEXT,'
      'id_room TEXT,'
      'shift_schedules INTEGER,'
      'day_schedules TEXT);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT '
        '$tableName.id_module_class,'
        '$tableName.id_schedule,'
        '$tableName.module_class_name,'
        '$tableName.id_room,'
        '$tableName.shift_schedules,'
        '$tableName.day_schedules,'
        '$eventScheduleTable.color,'
        '$eventScheduleTable.description '
        'FROM '
        '$tableName LEFT JOIN $eventScheduleTable '
        'ON $tableName.id_schedule = $eventScheduleTable.id_schedule;',
      );
    } on Exception catch (e) {
      print('$e in DbSchedule.all');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> get moduleClass async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT id_module_class '
        'FROM $tableName;',
      );
    } on Exception catch (e) {
      print('$e in DbSchedule.moduleClass');
      return [];
    }
  }

  Future<void> insert(List<ScheduleModel> rawData) async {
    assert(database != null, 'Database must not be null');

    rawData.forEach((element) async {
      try {
        await database!.insert(
          tableName,
          element.toMap(),
        );
      } on Exception catch (e) {
        print('Error: ${e.toString()} in DbSchedule.insert()');
      }
    });
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete(tableName);
    } on Exception catch (e) {
      print('Error: ${e.toString()} in DbSchedule.delete()');
    }
  }
}
