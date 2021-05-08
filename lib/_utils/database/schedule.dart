import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbSchedule extends TableModel {
  DbSchedule(Database database) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS schedule('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'id_module_class TEXT,'
      'module_class_name TEXT,'
      'id_room TEXT,'
      'shift_schedules INTEGER,'
      'day_schedules TEXT);';

  Future<List<Map<String, dynamic>>> get all async {
    try {
      return await database.rawQuery(
        'SELECT '
        'schedule.id_module_class,'
        'schedule.module_class_name,'
        'schedule.id_room,'
        'schedule.shift_schedules,'
        'schedule.day_schedules,'
        'color_event.color '
        'FROM '
        'schedule JOIN color_event '
        'ON schedule.id_module_class = color_event.id_module_class;',
      );
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> get moduleClass async {
    try {
      return await database.rawQuery(
        'SELECT '
            'schedule.id_module_class '
            'FROM '
            'schedule;',
      );
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> insert(Map<String, dynamic> schedule) async {
    try {
      await database.insert('schedule', schedule);
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> delete() async {
    try {
      await database.delete('schedule');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
