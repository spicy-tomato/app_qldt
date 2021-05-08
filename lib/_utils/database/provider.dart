import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:app_qldt/_utils/database/color_event.dart';
import 'package:app_qldt/_utils/database/notification.dart';
import 'package:app_qldt/_utils/database/schedule.dart';
import 'package:app_qldt/_utils/database/sender.dart';

class DatabaseProvider {
  late Database database;

  late DbSchedule schedule;
  late DbSender sender;
  late DbNotification notification;
  late DbColorEvent colorEvent;

  DatabaseProvider();

  Future<void> init() async {
    await _initDb();
    _initTables();
  }

  Future<void> _initDb() async {
    String path = await _getPath();
    bool dbExisted = await databaseExists(path);

    if (!dbExisted) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    await _openDb();
  }

  static Future<void> deleteDb() async {
    DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    String path = await databaseProvider._getPath();

    await databaseProvider.database.close();
    await deleteDatabase(path);
  }

  Future<void> _openDb() async {
    String path = await _getPath();

    database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _initTables() {
    schedule = DbSchedule(database);
    sender = DbSender(database);
    notification = DbNotification(database);
    colorEvent = DbColorEvent(database);
  }

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), 'core.db');
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      DbSchedule(db).create(db);
      DbSender(db).create(db);
      DbNotification(db).create(db);
      DbColorEvent(db).create(db);
    } on Exception catch (e) {
      print(e);
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {} on Exception catch (e) {
      print(e);
    }
  }
}
