import 'package:app_qldt/_utils/database/table/table_model.dart';
import 'package:sqflite/sqflite.dart';

class DbDataVersion extends TableModel {
  late int schedule;
  late int notification;
  late int examSchedule;
  late int score;

  DbDataVersion([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS data_version('
      'id_data INTEGER PRIMARY KEY AUTOINCREMENT,'
      'data_field TEXT,'
      'version INTEGER);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT * '
        'FROM data_version;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('data_version');
    }
  }

  static Future<void> insertInitial(Database db) async {
    List<String> _initialFields = ['schedule', 'notification', 'exam_schedule', 'score'];

    _initialFields.forEach((field) async {
      await db.insert('data_version', {
        'data_field': field,
        'version': 0,
      });
    });
  }

  Future<void> update(String dataField, int version) async {
    assert(database != null, 'Database must not be null');
    await database!.update('data_version', {dataField: version});
  }

  Future<void> getVersionToCache() async {
    schedule = int.parse((await database!.query(
      'data_version',
      columns: ['version'],
      where: 'data_field=?',
      whereArgs: ['schedule'],
    ))[0]['version']
        .toString());

    notification = int.parse((await database!.query(
      'data_version',
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['notification'],
    ))[0]['version']
        .toString());

    examSchedule = int.parse((await database!.query(
      'data_version',
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['exam_schedule'],
    ))[0]['version']
        .toString());

    score = int.parse((await database!.query(
      'data_version',
      where: 'data_field=?',
      columns: ['version'],
      whereArgs: ['score'],
    ))[0]['version']
        .toString());
  }

  Future<void> _setVersion(String field, int newVersion) async {
    await database!.update(
      'data_version',
      {
        'version': newVersion,
      },
      where: 'data_field=?',
      whereArgs: [field],
    );
  }

  Future<void> setScheduleVersion(int newVersion) async {
    await _setVersion('schedule', newVersion);
    schedule = newVersion;
  }

  Future<void> setNotificationVersion(int newVersion) async {
    await _setVersion('notification', newVersion);
    notification = newVersion;
  }

  Future<void> setExamScheduleVersion(int newVersion) async {
    await _setVersion('exam_schedule', newVersion);
    examSchedule = newVersion;
  }

  Future<void> setScoreVersion(int newVersion) async {
    await _setVersion('score', newVersion);
    score = newVersion;
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete('data_version');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
