import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbEventExam extends TableModel {
  DbEventExam([Database? database]) : super(database);

  static String get tableName => 'event_exam';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_exam INTEGER PRIMARY KEY,'
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
      debugPrint('$e in DbEventExam.map');
      return [];
    }
  }

  Future<void> update(Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.update(tableName, map);
    } on Exception catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
}
