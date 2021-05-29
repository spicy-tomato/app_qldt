import 'package:sqflite/sqflite.dart';

import 'db_schedule.dart';
import 'table_model.dart';

class DbColorEvent extends TableModel {
  DbColorEvent([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS color_event('
      'id_module_class TEXT,'
      'color TEXT,'
      'PRIMARY KEY (id_module_class, color));';

  Future<List<Map<String, dynamic>>> get map async {
    assert(database != null, 'Database must not be null');

    try {
      return await database!.rawQuery(
        'SELECT '
        'id_module_class,'
        'color '
        'FROM '
        'color_event;',
      );
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> update(Map<String, dynamic> map) async {
    assert(database != null, 'Database must not be null');

    try {
      await database!.update('color_event', map);
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> insertColorToNew(DbSchedule schedule) async {
    assert(database != null, 'Database must not be null');

    try {
      List<Map<String, dynamic>> moduleClassIdList = await schedule.moduleClass;

      moduleClassIdList.forEach((id) async {
        await database!.rawQuery(''
            'INSERT OR IGNORE '
            'INTO color_event(id_module_class, color) '
            'VALUES("${id['id_module_class']}", "0xff007bff");');
      });
    } on Exception catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
