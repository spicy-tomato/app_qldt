import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    return _database ?? await initDb();
  }

  Future<List<Map<String, dynamic>>> get schedule async {
    final _db = _database ?? await database;
    return await _db.query('Schedule');
  }

  Future<List<Map<String, dynamic>>> get notification async {
    final _db = _database ?? await database;
    try {
      return await _db.query(
        'Notification',
        orderBy: "ID_Notification DESC",
      );
    } on Exception catch (_) {
      await _database!.execute(notificationTable);
      return await _db.query('Notification');
    }
  }

  static const scheduleTable = ''
      'CREATE TABLE IF NOT EXISTS Schedule('
      'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'Id_Module_Class TEXT,'
      'Module_Name TEXT,'
      'Id_Room TEXT,'
      'Shift_Schedules INTEGER,'
      'Day_Schedules TEXT);';

  static const notificationTable = ''
      'CREATE TABLE IF NOT EXISTS Notification('
      'Id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'ID_Notification INTEGER,'
      'Title TEXT,'
      'Content TEXT,'
      'Typez TEXT,'
      'Sender TEXT,'
      'Time_Start TEXT,'
      'Time_End TEXT,'
      'Expired TEXT);';

  Future<Database> initDb() async {
    String path = await _getPath();
    // print('Initializing database');

    bool dbExisted = await databaseExists(path);

    if (!dbExisted) {
      // print('Db is not exists');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    await openDb();

    return _database!;
  }

  Future<void> deleteDb() async {
    String path = await _getPath();

    await _database?.close();
    await deleteDatabase(path);
  }

  Future<void> openDb() async {
    if (_database != null && _database!.isOpen) {
      return;
    }

    String path = await _getPath();

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        try {
          await db.execute(scheduleTable);
          await db.execute(notificationTable);
        } on Exception catch (e) {
          print(e);
        }
      },
    );
  }

  Future<void> insertSchedule(Map<String, dynamic> schedule) async {
    _database = await database;
    await _database!.insert('Schedule', schedule);
  }

  Future<void> deleteSchedule() async {
    try {
      _database = await database;
      await _database!.delete('Schedule');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> insertNotification(Map<String, dynamic> notification) async {
    _database = await database;
    await _database!.insert('Notification', notification);
  }

  Future<void> deleteNotification() async {
    try {
      _database = await database;
      await _database!.delete('Notification');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<String> _getPath() async {
    return join((await getDatabasesPath())!, 'core.db');
  }
}
