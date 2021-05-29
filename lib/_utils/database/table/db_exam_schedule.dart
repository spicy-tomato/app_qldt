import 'package:app_qldt/_utils/database/table/table_model.dart';
import 'package:sqflite/sqflite.dart';

class DbExamSchedule extends TableModel {
  DbExamSchedule([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS exam_schedule('
      'id_exam_schedule INTEGER PRIMARY KEY AUTOINCREMENT,'
      'semester TEXT,'
      'module_name TEXT,'
      'credit INTEGER,'
      'date_start TEXT,'
      'time_start TEXT,'
      'method TEXT,'
      'identification_number INTEGER,'
      'room TEXT);';

  Future<List<Map<String, dynamic>>> get all async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT * '
        'FROM exam_schedule '
        'ORDER BY semester, module_name COLLATE LOCALIZED;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('exam_schedule');
    }
  }

  Future<List<Map<String, dynamic>>> get semester async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT semester '
        'FROM exam_schedule '
        'GROUP BY semester '
        'ORDER BY semester;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query('exam_schedule');
    }
  }

  Future<void> insert(Map<String, dynamic> examSchedule) async {
    assert(database != null, 'Database must not be null');
    await database!.insert('exam_schedule', examSchedule);
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete('exam_schedule');
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
