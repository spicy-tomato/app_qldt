import 'dart:io';

import 'package:app_qldt/_utils/database/table/data_version.dart';
import 'package:app_qldt/_utils/database/table/db_event.dart';
import 'package:app_qldt/_utils/database/table/db_event_exam.dart';
import 'package:app_qldt/_utils/database/table/db_event_schedule.dart';
import 'package:app_qldt/_utils/database/table/db_exam_schedule.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'table/table.dart';

class DatabaseProvider {
  late Database database;

  late DbSchedule schedule;
  late DbSender sender;
  late DbNotification notification;
  late DbColorEvent colorEvent;
  late DbScore score;
  late DbExamSchedule examSchedule;
  late DbDataVersion dataVersion;
  late DbEvent event;
  late DbEventSchedule eventSchedule;
  late DbEventExam eventExam;

  DatabaseProvider();

  Future<void> init() async {
    await _initDb();
    await _initTables();

    debugPrint('DbProvider: Schedule version ${dataVersion.schedule}');
    debugPrint('DbProvider: Notification version ${dataVersion.notification}');
    debugPrint('DbProvider: ExamSchedule version ${dataVersion.examSchedule}');
    debugPrint('DbProvider: Score version ${dataVersion.score}');
  }

  Future<void> _initDb() async {
    final String path = await _getPath();
    final bool dbExisted = await databaseExists(path);

    if (!dbExisted) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
    }

    await _openDb();
  }

  static Future<void> deleteDb() async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    final String path = await databaseProvider._getPath();

    await databaseProvider.database.close();
    await deleteDatabase(path);
  }

  Future<void> _openDb() async {
    final String path = await _getPath();

    database = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _initTables() async {
    schedule = DbSchedule(database);
    sender = DbSender(database);
    notification = DbNotification(database);
    colorEvent = DbColorEvent(database);
    score = DbScore(database);
    examSchedule = DbExamSchedule(database);
    event = DbEvent(database);
    eventSchedule = DbEventSchedule(database);
    eventExam = DbEventExam(database);
    dataVersion = DbDataVersion(database);
    await dataVersion.getVersionToCache();
  }

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), 'core.db');
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      DbSchedule().create(db);
      DbSender().create(db);
      DbNotification().create(db);
      DbColorEvent().create(db);
      DbScore().create(db);
      DbExamSchedule().create(db);
      DbEvent().create(db);
      DbEventSchedule().create(db);
      DbEventExam().create(db);

      final dv = DbDataVersion();
      dv.create(db);
      DbDataVersion.insertInitial(db);
    } on Exception catch (e) {
      debugPrint('$e in DatabaseProvider._onCreate()');
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      if (oldVersion < 2) {
        await _upgradeToV2(db);
      }
    } on Exception catch (e) {
      debugPrint('$e in DatabaseProvider._onUpgrade()');
    }
  }

  Future<void> _upgradeToV2(Database db) async {}
}
