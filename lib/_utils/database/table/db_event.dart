import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbEvent extends TableModel {
  DbEvent([Database? database]) : super(database);

  static String get tableName => 'event';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_event INTEGER PRIMARY KEY AUTOINCREMENT,'
      'name TEXT,'
      'color INTEGER,'
      'location TEXT,'
      'description TEXT,'
      'time_start TEXT,'
      'time_end TEXT,'
      'is_all_day INTEGER,'
      'people TEXT);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.query(tableName);
    } on Exception catch (e) {
      print('$e in DbEvent.get');
      return [];
    }
  }

  Future<int?> insert(Map<String, dynamic> event) async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.insert(tableName, event);
    } on Exception catch (e) {
      print('$e in DbEvent.insert()');
    }
  }

  Future<void> update(Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.update(tableName, map);
    } on Exception catch (e) {
      print('Error: ${e.toString()} in DbEvent.update()');
    }
  }

  Future<void> delete(int id) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete(
        tableName,
        where: 'id_event=?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      print('Error: ${e.toString()} in DbEvent.delete()');
    }
  }
}
