import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbSender extends TableModel {
  DbSender(Database database) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS sender('
      'id_sender TEXT,'
      'sender_name TEXT,'
      'permission INTEGER);';

  Future<void> insertSender(Map<String, dynamic> sender) async {
    await database.insert('sender', sender);
  }

  Future<void> delete() async {
    try {
      await database.delete('sender');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
