import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_services/api/api_score_service.dart';
import 'package:app_qldt/_services/controller/service_controller.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_services/model/service_response.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';

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

  Future<void> refresh() async {
    ServiceResponse response = await apiService.request();

    if (response.statusCode == 200) {
      List<ScoreModel> newData = _parseData(response.data);
      await localService.saveNewData(newData);
      await localService.updateVersion(response.version!);
    } else {
      await localService.loadOldData();
      if (response.statusCode == 204) {
        connected = true;
      } else {
        print("Error with status code: ${response.statusCode} at score_service_controller.dart");
      }
    }
  }

  List<ScoreModel> getScoreDataOfAllEvaluation(SemesterModel semester) {
    return scoreData.where((score) => score.semester == semester.query).toList();
  }

  List<ScoreModel> getScoreDataOfAllSemester(SubjectEvaluation subjectEvaluation) {
    if (subjectEvaluation == SubjectEvaluation.pass) {
      return scoreData.where((score) => score.evaluation == SubjectEvaluation.pass.query).toList();
    }
    //  Fail
    else {
      List<ScoreModel> newScoreData = [];
      List<ScoreModel> passedScoreData =
          scoreData.where((score) => score.evaluation == SubjectEvaluation.pass.query).toList();

      scoreData.forEach((score) {
        if (score.evaluation == SubjectEvaluation.fail.query) {
          bool fail = true;

          passedScoreData.forEach((passedScore) {
            if (score.moduleName == passedScore.moduleName) {
              fail = false;
            }
          });

          if (fail) {
            newScoreData.add(score);
          }
        }
      });

      return newScoreData;
    }
  }

  List<ScoreModel> getSpecificScoreData(SemesterModel semester, SubjectEvaluation subjectEvaluation) {
    return getScoreDataOfAllSemester(subjectEvaluation)
        .where((score) => score.semester == semester.query)
        .toList();
  }

  List<ScoreModel> getGpaModulesData() {
    return scoreData
        .where((element) =>
            element.moduleName.indexOf('Giáo dục thể chất') == -1 &&
            element.moduleName.indexOf('Giáo dục QP-AN') == -1 &&
            element.moduleName != 'Tiếng Anh A1' &&
            element.moduleName != 'Tiếng Anh A2')
        .toList();
  }

  List<ScoreModel> _parseData(dynamic responseData) {
    List data = responseData as List;
    List<ScoreModel> listModel = [];

    for (var element in data) {
      listModel.add(ScoreModel.fromJson(element));
    }

    return listModel;
  }
}
