import 'package:app_qldt/models/score/score_models.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbScore extends TableModel {
  DbScore([Database? database]) : super(database);

  static String get tableName => 'score';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_score INTEGER PRIMARY KEY AUTOINCREMENT,'
      'module_name TEXT,'
      'semester TEXT,'
      'credit INTEGER,'
      'evaluation INTEGER,'
      'process_score REAL,'
      'test_score REAL,'
      'theoretical_score REAL);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT * '
        'FROM $tableName '
        'ORDER BY semester, module_name COLLATE LOCALIZED;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('score');
    }
  }

  Future<List<Map<String, dynamic>>> get semester async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT semester '
        'FROM $tableName '
        'GROUP BY semester '
        'ORDER BY semester;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query(tableName);
    }
  }

  Future<void> insert(List<ScoreModel> rawData) async {
    assert(database != null, 'Database must not be null');

    for (var element in rawData) {
      await database!.insert(tableName, element.toMap());
    }
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete(tableName);
    } on Exception catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }
}
