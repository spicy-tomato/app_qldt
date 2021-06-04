import 'package:sqflite/sqflite.dart';

abstract class TableModel {
  final Database? database;

  String get createScript;

  TableModel([this.database]);

  Future<void> create(database) async {
    await database.execute(createScript);
  }
}
