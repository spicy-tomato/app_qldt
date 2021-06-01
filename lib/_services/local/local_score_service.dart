import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_services/local/local_service.dart';
import 'package:app_qldt/_services/web/exception/no_score_data_exception.dart';
import 'package:app_qldt/_services/web/score_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/_models/semester_model.dart';

class LocalScoreService extends LocalService {
  late final ScoreService _scoreService;

  List<ScoreModel> scoreData = [];
  List<SemesterModel> semester = [];

  LocalScoreService({DatabaseProvider? databaseProvider, required String userId})
      : _scoreService = ScoreService(userId),
        super(databaseProvider);

  Future<List<ScoreModel>?> refresh() async {
    try {
      List<ScoreModel>? data = await _scoreService.getScore();

      if (data != null) {
        await removeOld();
        await _saveNew(data);
      }

      scoreData = await _getScoreDataFromDb();
      semester = await _getSemesterFromDb();

      connected = true;

      return this.scoreData;
    } on NoScoreDataException catch (_) {
      connected = false;
      return null;
    }
  }

  Future<void> _saveNew(List<ScoreModel> rawData) async {
    for (var row in rawData) {
      await databaseProvider.score.insert(row.toMap());
    }
  }

  Future<void> removeOld() async {
    await databaseProvider.score.delete();
  }

  Future<List<ScoreModel>> _getScoreDataFromDb() async {
    final rawData = await databaseProvider.score.all;

    return rawData.map((data) {
      return ScoreModel.fromMap(data);
    }).toList();
  }

  Future<List<SemesterModel>> _getSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await databaseProvider.score.semester;
    final List<SemesterModel> list = [SemesterModel.all];

    rawData.forEach((data) {
      list.add(SemesterModel(data['semester'].toString()));
    });

    return list;
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
}
