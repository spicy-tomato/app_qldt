import 'package:app_qldt/enums/score/score_enum.dart';
import 'package:app_qldt/models/event/semester_model.dart';
import 'package:app_qldt/models/score/score_models.dart';
import 'package:app_qldt/models/service/service_controller_data.dart';
import 'package:app_qldt/services/api/api_score_service.dart';
import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:app_qldt/services/local/local_score_service.dart';
import 'package:app_qldt/services/model/service_response.dart';
import 'package:flutter/widgets.dart';

class ScoreServiceController extends ServiceController<LocalScoreService, ApiScoreService> {
  ScoreServiceController(ServiceControllerData data)
      : super(
          LocalScoreService(databaseProvider: data.databaseProvider),
          ApiScoreService(
            idUser: data.idUser,
            apiUrl: data.apiUrl,
          ),
        );

  List<ScoreModel> get scoreData => localService.scoreData;

  List<SemesterModel> get semester => localService.semester;

  SemesterModel? get lastSemester => localService.lastSemester;

  Future<void> refresh([int? newVersion]) async {
    ServiceResponse response = await apiService.request();

    if (response.statusCode == 200) {
      List<ScoreModel> newData = _parseData(response.data);
      await localService.saveNewData(newData);
      await localService.updateVersion(newVersion);
      setConnected();
    } else {
      await localService.loadOldData();
      if (response.statusCode == 204 && localService.databaseProvider.dataVersion.score > 0) {
        setConnected();
      } else {
        debugPrint('Error with status code: ${response.statusCode} at score_service_controller.dart');
      }
    }
  }

  Future<void> load() async {
    await localService.loadOldData();
  }

  List<ScoreModel> getScoreDataOfAllEvaluation(SemesterModel semester) {
    return scoreData.where((s) => s.semester == semester.query).toList();
  }

  List<ScoreModel> getScoreDataOfAllSemester(SubjectEvaluation subjectEvaluation) {
    //  All Subjects
    if (subjectEvaluation.isAll) {
      return scoreData;
    }

    //  Passed Subjects
    if (subjectEvaluation.isPass) {
      return scoreData.where((s) => s.evaluation == SubjectEvaluation.pass.query).toList();
    }

    //  Failed Subjects
    List<ScoreModel> newScoreData = [];
    List<ScoreModel> passedScoreData = scoreData.where((s) => s.evaluation == SubjectEvaluation.pass.query).toList();

    for (var score in scoreData) {
      if (score.evaluation == SubjectEvaluation.fail.query) {
        bool fail = true;

        for (var passedScore in passedScoreData) {
          if (score.moduleName == passedScore.moduleName) {
            fail = false;
          }
        }

        if (fail) {
          newScoreData.add(score);
        }
      }
    }

    return newScoreData;
  }

  List<ScoreModel> getScoreOfLastSemester() {
    final semester = lastSemester;

    if (semester == null) {
      return [];
    }

    return scoreData.where((s) => s.semester == semester.query).toList();
  }

  List<ScoreModel> getSpecificScoreData(SemesterModel semester, SubjectEvaluation subjectEvaluation) {
    return getScoreDataOfAllSemester(subjectEvaluation).where((score) => score.semester == semester.query).toList();
  }

  List<ScoreModel> getGpaModulesData() {
    return scoreData
        .where((element) =>
            !element.moduleName.contains('Giáo dục thể chất') &&
            !element.moduleName.contains('Giáo dục QP-AN') &&
            element.moduleName != 'Tiếng Anh A1' &&
            element.moduleName != 'Tiếng Anh A2')
        .toList();
  }

  List<ScoreModel> _parseData(dynamic responseData) {
    List data = responseData as List;
    return data.map((x) => ScoreModel.fromJson(x)).toList();
  }
}
