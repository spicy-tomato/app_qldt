import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  DatabaseProvider._();

  Future<Database> get database async {
    return _database ?? await initDb();
  }

  static const scheduleTable = ''
      'CREATE TABLE IF NOT EXISTS Schedule('
      'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'Id_Module_Class TEXT,'
      'Module_Name TEXT,'
      'Id_Room TEXT,'
      'Shift_Schedules INTEGER,'
      'Day_Schedules TEXT);';

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'core.db');
    print('Initializing database');

    bool dbExisted = await databaseExists(path);

    if (!dbExisted) {
      print('Db is not exists');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(scheduleTable);
      },
    );
  }

  Future<List> get schedule async {
    final _db = await database;
    return await _db.query('Schedule');
  }

  Future<void> insertSchedule(Map<String, dynamic> schedule) async {
    final _db = await database;
    await _db.insert('Schedule', schedule);
  }

  Future<void> deleteSchedule() async {
    try {
      final _db = await database;
      await _db.delete('Schedule');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
