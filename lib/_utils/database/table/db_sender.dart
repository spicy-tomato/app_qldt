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

  Future<void> insert(Map<String, dynamic> sender) async {
    assert(database != null, 'Database must not be null');

    await database!.insert(
      tableName,
      sender,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
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
