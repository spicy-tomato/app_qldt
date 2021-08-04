import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_utils/database/table/table_model.dart';
import 'package:sqflite/sqflite.dart';

class DbExamSchedule extends TableModel {
  DbExamSchedule([Database? database]) : super(database);

  static String get tableName => 'exam_schedule';

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS $tableName('
      'id_exam_schedule INTEGER PRIMARY KEY,'
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
      return await database!.query(tableName);
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query(tableName);
    }
  }

  Future<List<Map<String, dynamic>>> get semester async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT semester '
        'FROM $tableName '
        'GROUP BY semester '
        'ORDER BY semester;',
      );
    } on Exception catch (_) {
      await database!.execute(createScript);
      return await database!.query(tableName);
    }
  }

  Future<void> insert(List<ExamScheduleModel> rawData) async {
    assert(database != null, 'Database must not be null');

    for (var element in rawData) {
      await database!.insert(tableName, element.toMap());
    }
  }

  Future<void> delete() async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.delete(tableName);
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
