import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbEventSchedule extends TableModel {
  DbEventSchedule([Database? database]) : super(database);

  static String get tableName => 'event_schedule';

  static String get scheduleTable => 'schedule';

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
      print('$e in DbEventSchedule.map');
      return [];
    }
  }

  ///
  /// map:
  /// {
  ///   'id_schedule':  [String],
  ///   'color':        [int],
  ///   'description':  [String]
  /// }
  Future<void> update(Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.insert(
        tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> updateWithName(String eventName, Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    List<Map<String, dynamic>> eventList = await database!.query(
      scheduleTable,
      where: 'module_class_name=?',
      whereArgs: [eventName],
      columns: ['id_schedule'],
    );

    try {
      for (var event in eventList) {
        map['id_schedule'] = event['id_schedule'];
        try {
          await database!.insert(
            tableName,
            map,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        } on Exception catch (e) {
          print('Error: ${e.toString()} in updateWithName');
        }
      }
    } on Exception catch (e) {
      print('Error: ${e.toString()} in updateWithName');
    }
  }
}
