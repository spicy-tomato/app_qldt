import 'package:app_qldt/models/notification/receive_notification_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbNotification extends TableModel {
  DbNotification([Database? database]) : super(database);

  static String get tableName => 'notification';

  static String get senderTable => 'sender';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_notification INTEGER PRIMARY KEY,'
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

  Future<int?> get lastId async {
    assert(database != null, 'Database must not be null');

    try {
      final int lastId = (await database!.query(
        tableName,
        columns: ['id_notification'],
        orderBy: 'id_notification DESC',
        limit: 1,
      ))[0]['id_notification']! as int;

      debugPrint('Last notification id: $lastId');
      return lastId;
    } on Error catch (e) {
      debugPrint('$e in DbNotification.lastId');
      return null;
    }
  }

  Future<void> insert(List<ReceiveNotificationModel> rawData) async {
    assert(database != null, 'Database must not be null');

    for (final element in rawData) {
      try {
        await database!.insert(
          tableName,
          element.toMap(),
        );
      } on Exception catch (e) {
        debugPrint('$e in DbNotification.insert()');
      }
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

  Future<void> deleteRow(List<int> list) async {
    assert(database != null, 'Database must not be null');

    for (final element in list) {
      try {
        await database!.delete(
          tableName,
          where: 'id_notification=?',
          whereArgs: [element],
        );
      } on Exception catch (e) {
        debugPrint('Error: ${e.toString()}');
      }
    }
  }
}
