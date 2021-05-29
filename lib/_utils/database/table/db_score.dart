import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbScore extends TableModel {
  DbScore([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS score('
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
        'FROM score '
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
        'FROM score '
        'GROUP BY semester '
        'ORDER BY semester;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('score');
    }
  }

  Future<void> insert(Map<String, dynamic> score) async {
    assert(database != null, 'Database must not be null');
    await database!.insert('score', score);
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete('score');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
