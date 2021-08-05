import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_services/api/api_exam_schedule_service.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_exam_schedule_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';
import 'package:flutter/widgets.dart';

class ExamScheduleServiceController
    extends ServiceController<LocalExamScheduleService, ApiExamScheduleService> {
  ExamScheduleServiceController(ServiceControllerData data)
      : super(
          LocalExamScheduleService(databaseProvider: data.databaseProvider),
          ApiExamScheduleService(
            idUser: data.idUser,
            apiUrl: data.apiUrl,
          ),
        );

  List<ExamScheduleModel> get examScheduleData => localService.examScheduleData;

  List<SemesterModel> get semester => localService.semester;

  SemesterModel? get lastSemester => localService.lastSemester;

  Future<void> refresh([int? newVersion]) async {
    ServiceResponse response = await apiService.request();

    if (response.statusCode == 200) {
      List<ExamScheduleModel> newData = _parseData(response.data);
      await localService.updateVersion(newVersion);
      await localService.saveNewData(newData);
      setConnected();
    } else {
      if (response.statusCode == 204 && localService.databaseProvider.dataVersion.examSchedule > 0) {
        setConnected();
      } else {
        debugPrint('Error with status code: ${response.statusCode} at exam_schedule_service_controller.dart');
      }
    }
  }

  Future<void> load() async {
    await localService.loadOldData();
  }

  List<ExamScheduleModel> _parseData(dynamic responseData) {
    List data = responseData as List;
    List<ExamScheduleModel> listModel = [];

    for (var element in data) {
      listModel.add(ExamScheduleModel.fromJson(element));
    }

    return listModel;
  }

  List<ExamScheduleModel> getExamScheduleOfSemester(SemesterModel? semester) {
    if (semester == null) {
      return [];
    }

    List<ExamScheduleModel> res = examScheduleData.where((e) => e.semester == semester.query).toList();

    return res;
  }

  List<ExamScheduleModel> getExamScheduleOfLastSemester() {
    final semester = lastSemester;

    if (semester == null) {
      return [];
    }

    return examScheduleData.where((e) => e.semester == semester.query).toList();
  }
}
