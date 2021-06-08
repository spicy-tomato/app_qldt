import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_services/api/api_service.dart';
import 'package:app_qldt/_services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_models/semester_model.dart';

class LocalExamScheduleService extends LocalService {
  List<ExamScheduleModel> examScheduleData = [];
  List<SemesterModel> semester = [];

  LocalExamScheduleService({DatabaseProvider? databaseProvider}) : super(databaseProvider);

  @override
  ServiceController<LocalService, ApiService> get serviceController =>
      controller as ExamScheduleServiceController;

  Future<List<ExamScheduleModel>?> saveNewData(List<ExamScheduleModel> newData) async {
    print('ExamSchedule service: Updating new data');

    await _removeOld();
    await _saveNew(newData);

    await _loadExamScheduleDataFromDb();
    await _loadSemesterFromDb();

    controller.connected = true;

    return this.examScheduleData;
  }

  Future<void> updateVersion() async {
    await databaseProvider.dataVersion.setExamScheduleVersion();
  }

  Future<void> loadOldData() async {
    await _loadExamScheduleDataFromDb();
    await _loadSemesterFromDb();
  }

  Future<void> _removeOld() async {
    await databaseProvider.examSchedule.delete();
  }

  Future<void> _saveNew(List<ExamScheduleModel> rawData) async {
    for (var row in rawData) {
      await databaseProvider.examSchedule.insert(row.toMap());
    }
  }

  Future<void> _loadExamScheduleDataFromDb() async {
    final rawData = await databaseProvider.examSchedule.all;

    examScheduleData = rawData.map((data) {
      return ExamScheduleModel.fromMap(data);
    }).toList();
  }

  Future<void> _loadSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await databaseProvider.examSchedule.semester;
    final List<SemesterModel> list = [];

    rawData.forEach((data) {
      list.add(SemesterModel(data['semester'].toString()));
    });

    semester = list;
  }
}
