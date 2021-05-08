import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbNotification extends TableModel {
  DbNotification([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS notification('
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
        'notification.id_notification,'
        'notification.title,'
        'notification.content,'
        'notification.typez,'
        'notification.time_start,'
        'notification.time_end,'
        'notification.time_created,'
        'sender.sender_name '
        'FROM '
        'notification JOIN sender '
        'ON notification.id_sender = sender.id_sender '
        'ORDER BY notification.id_notification DESC;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('notification');
    }
  }

  Future<void> insert(Map<String, dynamic> notification) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.insert('notification', notification);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete('notification');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
