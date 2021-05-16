import 'package:app_qldt/_models/exam_schedule.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_services/web/exam_schedule_service.dart';
import 'package:app_qldt/_services/web/exception/no_exam_schedule_data_exception.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_models/semester.dart';

class LocalExamScheduleService extends LocalService {
  late final ExamScheduleService _examScheduleService;

  List<ExamSchedule> examScheduleData = [];
  List<Semester> semester = [];

  LocalExamScheduleService({DatabaseProvider? databaseProvider, required String userId})
      : _examScheduleService = ExamScheduleService(userId),
        super(databaseProvider);

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
      await databaseProvider.examSchedule.insert(row.toMap());
    }
  }

  Future<void> _removeOld() async {
    await databaseProvider.examSchedule.delete();
  }

  Future<List<ExamSchedule>> _getExamScheduleDataFromDb() async {
    final rawData = await databaseProvider.examSchedule.all;

    return rawData.map((data) {
      return ExamSchedule.fromMap(data);
    }).toList();
  }

  Future<List<Semester>> _getSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await databaseProvider.examSchedule.semester;
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
