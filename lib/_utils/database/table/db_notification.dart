import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbNotification extends TableModel {
  DbNotification([Database? database]) : super(database);

  static String get tableName => 'notification';

  static String get senderTable => 'sender';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'id_notification INTEGER,'
      'title TEXT,'
      'content TEXT,'
      'typez TEXT,'
      'id_sender INTEGER,'
      'time_created TEXT,'
      'time_start TEXT,'
      'time_end TEXT);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT '
        '$tableName.id_notification,'
        '$tableName.title,'
        '$tableName.content,'
        '$tableName.typez,'
        '$tableName.time_start,'
        '$tableName.time_end,'
        '$tableName.time_created,'
        '$senderTable.sender_name '
        'FROM '
        '$tableName JOIN sender '
        'ON $tableName.id_sender = $senderTable.id_sender '
        'ORDER BY $tableName.id_notification DESC;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query(tableName);
    }
  }

  Future<void> insert(Map<String, dynamic> notification) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.insert(tableName, notification);
    } on Exception catch (e) {
      print('$e in DbNotification.insert()');
    }
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete(tableName);
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
