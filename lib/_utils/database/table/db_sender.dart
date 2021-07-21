import 'package:app_qldt/_models/sender_model.dart';
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

    rawData.forEach((element) async {
      await database!.insert(
        tableName,
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    });
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
