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
    return await _db.query('schedule');
  }

  Future<List<Map<String, dynamic>>> get notification async {
    final _db = _database ?? await database;
    try {
      return await _db.rawQuery(
        'SELECT '
            'notification.id_notification,'
            'notification.title,'
            'notification.content,'
            'notification.typez,'
            'notification.time_start,'
            'notification.time_end,'
            'notification.expired,'
            'sender.sender_name '
        'FROM '
            'notification JOIN sender '
            'ON notification.id_sender = sender.id_sender '
        'ORDER BY notification.id_notification DESC;',
      );
    } on Exception catch (_) {
      await _database!.execute(notificationTable);
      return await _db.query('notification');
    }
  }

  static const scheduleTable = ''
      'CREATE TABLE IF NOT EXISTS schedule('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'id_module_class TEXT,'
      'module_name TEXT,'
      'id_room TEXT,'
      'shift_schedules INTEGER,'
      'day_schedules TEXT);';

  static const notificationTable = ''
      'CREATE TABLE IF NOT EXISTS notification('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'id_notification INTEGER,'
      'title TEXT,'
      'content TEXT,'
      'typez TEXT,'
      'id_sender INTEGER,'
      'time_start TEXT,'
      'time_end TEXT,'
      'expired TEXT);';

  static const senderTable = ''
      'CREATE TABLE IF NOT EXISTS sender('
      'id_sender TEXT,'
      'sender_name TEXT,'
      'permission INTEGER);';

  Future<Database> initDb() async {
    String path = await _getPath();
    print('Initializing database');

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
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    try {
      await db.execute(scheduleTable);
      await db.execute(notificationTable);
      await db.execute(senderTable);
    } on Exception catch (e) {
      print(e);
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
    } on Exception catch (e) {
      print(e);
    }
  }

  //#region schedule
  Future<void> insertSchedule(Map<String, dynamic> schedule) async {
    _database = await database;
    await _database!.insert('schedule', schedule);
  }

  Future<void> deleteSchedule() async {
    try {
      _database = await database;

      await _database!.delete('schedule');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  //#endregion

  //#region notification
  Future<void> insertNotification(Map<String, dynamic> notification) async {
    _database = await database;

    try {
      await _database!.insert('notification', notification);
    } on Exception catch(e){
      print(e);
    }
  }

  Future<void> deleteNotification() async {
    try {
      _database = await database;
      await _database!.delete('notification');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  //#endregion

  //#region sender
  Future<void> insertSender(Map<String, dynamic> sender) async {
    _database = await database;
    await _database!.insert('sender', sender);
  }

  Future<void> deleteSender() async {
    try {
      _database = await database;

      await _database!.delete('sender');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
  //#endregion

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), 'core.db');
  }
}
