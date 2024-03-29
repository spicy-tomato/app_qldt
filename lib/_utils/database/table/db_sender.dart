import 'package:app_qldt/models/notification/sender_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbSender extends TableModel {
  DbSender([Database? database]) : super(database);

  static String get tableName => 'sender';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_sender INTEGER PRIMARY KEY,'
      'sender_name TEXT,'
      'permission INTEGER);';

  Future<void> insert(List<SenderModel> rawData) async {
    assert(database != null, 'Database must not be null');

    for (final element in rawData) {
      await database!.insert(
        tableName,
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
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
