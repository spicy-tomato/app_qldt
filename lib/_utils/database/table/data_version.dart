import 'package:app_qldt/_utils/database/table/table_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class DbDataVersion extends TableModel {
  late int schedule;
  late int notification;
  late int examSchedule;
  late int score;

  DbDataVersion([Database? database]) : super(database);

  static String get tableName => 'data_version';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_data INTEGER PRIMARY KEY AUTOINCREMENT,'
      'data_field TEXT,'
      'version INTEGER);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.query(tableName);
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query(tableName);
    }
  }

  static Future<void> insertInitial(Database db) async {
    final List<String> _initialFields = ['schedule', 'notification', 'exam_schedule', 'score'];

    for (final field in _initialFields) {
      await db.insert(tableName, {
        'data_field': field,
        'version': 0,
      });
    }
  }

  Future<void> update(String dataField, int version) async {
    assert(database != null, 'Database must not be null');
    await database!.update(tableName, {dataField: version});
  }

  Future<void> getVersionToCache() async {
    schedule = int.parse((await database!.query(
      tableName,
      columns: ['version'],
      where: 'data_field=?',
      whereArgs: ['schedule'],
    ))[0]['version']
        .toString());

    notification = int.parse((await database!.query(
      tableName,
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['notification'],
    ))[0]['version']
        .toString());

    examSchedule = int.parse((await database!.query(
      tableName,
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['exam_schedule'],
    ))[0]['version']
        .toString());

    score = int.parse((await database!.query(
      tableName,
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['score'],
    ))[0]['version']
        .toString());
  }

  Future<void> _setVersion(String field, int newVersion) async {
    await database!.update(
      tableName,
      {
        'version': newVersion,
      },
      where: 'data_field=?',
      whereArgs: [field],
    );
  }

  Future<void> updateScheduleVersion(int newVersion) async {
    await _setVersion('schedule', newVersion);
    schedule = newVersion;
  }

  Future<void> updateNotificationVersion(int newVersion) async {
    await _setVersion('notification', newVersion);
    notification = newVersion;
  }

  Future<void> updateExamScheduleVersion(int? newVersion) async {
    if (newVersion != null) {
      examSchedule = newVersion;
    } else {
      examSchedule++;
    }

    await _setVersion('exam_schedule', examSchedule);
  }

  Future<void> updateScoreVersion(int? newVersion) async {
    if (newVersion != null) {
      score = newVersion;
    } else {
      score++;
    }

    await _setVersion('score', score);
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
