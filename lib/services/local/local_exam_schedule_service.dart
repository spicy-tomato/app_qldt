import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/models/event/semester_model.dart';
import 'package:app_qldt/models/exam_schedule/exam_schedule_model.dart';
import 'package:app_qldt/services/api/api_service.dart';
import 'package:app_qldt/services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:app_qldt/services/local/local_service.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class LocalExamScheduleService extends LocalService {
  List<ExamScheduleModel> examScheduleData = [];
  List<SemesterModel> semester = [];

  SemesterModel? get lastSemester => semester.isEmpty ? null : semester[semester.length - 1];

  LocalExamScheduleService({DatabaseProvider? databaseProvider}) : super(databaseProvider);

  @override
  ServiceController<LocalService, ApiService> get serviceController =>
      controller as ExamScheduleServiceController;

  Future<List<ExamScheduleModel>?> saveNewData(List<ExamScheduleModel> newData) async {
    debugPrint('ExamSchedule service: Updating new data');

    await _removeOld();
    await _saveNew(newData);

    await _loadExamScheduleDataFromDb();
    await _loadSemesterFromDb();

    connected = true;

    return examScheduleData;
  }

  Future<void> updateVersion(int? newVersion) async {
    await databaseProvider.dataVersion.updateExamScheduleVersion(newVersion);
  }

  Future<void> loadOldData() async {
    await _loadExamScheduleDataFromDb();
    await _loadSemesterFromDb();
  }

  Future<void> _removeOld() async {
    await databaseProvider.examSchedule.delete();
  }

  Future<void> _saveNew(List<ExamScheduleModel> rawData) async {
    await databaseProvider.examSchedule.insert(rawData);
  }

  Future<void> _loadExamScheduleDataFromDb() async {
    final rawData = await databaseProvider.examSchedule.all;
    final dateFormat = DateFormat('d-M-yyyy');

    examScheduleData = rawData.map((data) {
      return ExamScheduleModel.fromMap(data);
    }).toList();

    examScheduleData.sort((a, b) => dateFormat.parse(a.dateStart).compareTo(dateFormat.parse(b.dateStart)));
  }

  Future<void> _loadSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await databaseProvider.examSchedule.semester;
    final List<SemesterModel> list = [];

    for (var data in rawData){
      list.add(SemesterModel(data['semester'].toString()));
    }

    semester = list;
  }
}
