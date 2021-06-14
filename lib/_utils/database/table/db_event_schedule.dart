import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbEventSchedule extends TableModel {
  DbEventSchedule([Database? database]) : super(database);

  static String get tableName => 'event_schedule';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_schedule INTEGER PRIMARY KEY,'
      'color INTEGER,'
      'description TEXT)';

  Future<List<Map<String, dynamic>>> get map async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT * '
        'FROM $tableName;',
      );
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> update(Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.update(tableName, map);
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
