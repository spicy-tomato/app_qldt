import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

import 'table_model.dart';

class DbColorEvent extends TableModel {
  DbColorEvent([Database? database]) : super(database);

  @override
  String get createScript => ''
      'CREATE TABLE IF NOT EXISTS color_event('
      'id_module_class TEXT,'
      'color INTEGER,'
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
      debugPrint('$e in DbColorEvent.get');
      return [];
    }
  }

  // Future<void> update(Map<String, dynamic> map) async {
  //   assert(database != null, 'Database must not be null');
  //
  //   try {
  //     await database!.update('color_event', map);
  //   } on Exception catch (e) {
  //     debugPrint('Error: ${e.toString()}');
  //   }
  // }
}
