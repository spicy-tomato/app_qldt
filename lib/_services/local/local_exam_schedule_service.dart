import 'package:app_qldt/_models/exam_schedule.dart';
import 'package:app_qldt/_services/web/exam_schedule_service.dart';
import 'package:app_qldt/_services/web/exception/no_exam_schedule_data_exception.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_models/semester.dart';

class LocalExamScheduleService {
  final String? userId;
  late DatabaseProvider _databaseProvider;
  late final ExamScheduleService _examScheduleService;
  late bool connected;

  List<ExamSchedule> examScheduleData = [];
  List<Semester> semester = [];

  LocalExamScheduleService({DatabaseProvider? databaseProvider, this.userId}) {
    this._databaseProvider = databaseProvider ?? DatabaseProvider();

    if (userId != null) {
      _examScheduleService = ExamScheduleService(userId!);
    }
  }

  Semester? get lastSemester => semester.length == 0 ? null : semester[semester.length - 1];

  Future<List<ExamSchedule>?> refresh() async {
    try {
      List<ExamSchedule>? data = await _examScheduleService.getExamSchedule();

      if (data != null) {
        await _removeOld();
        await _saveNew(data);
      }

      examScheduleData = await _getExamScheduleDataFromDb();
      semester = await _getSemesterFromDb();

      connected = true;

      return this.examScheduleData;
    } on NoExamScheduleDataException catch (_) {
      connected = false;
      return null;
    }
  }

  Future<void> _saveNew(List<ExamSchedule> rawData) async {
    for (var row in rawData) {
      await _databaseProvider.examSchedule.insert(row.toMap());
    }
  }

  Future<void> _removeOld() async {
    await _databaseProvider.examSchedule.delete();
  }

  Future<List<ExamSchedule>> _getExamScheduleDataFromDb() async {
    final rawData = await _databaseProvider.examSchedule.all;

    return rawData.map((data) {
      return ExamSchedule.fromMap(data);
    }).toList();
  }

  Future<List<Semester>> _getSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await _databaseProvider.examSchedule.semester;
    final List<Semester> list = [];

    rawData.forEach((data) {
      list.add(Semester(data['semester'].toString()));
    });

    return list;
  }

  List<ExamSchedule> getExamScheduleOfSemester(Semester semester) {
    return examScheduleData.where((examSchedule) {
      return examSchedule.semester == semester.query;
    }).toList();
  }
}
