import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/models/event/semester_model.dart';
import 'package:app_qldt/models/score/score_models.dart';
import 'package:app_qldt/services/api/api_service.dart';
import 'package:app_qldt/services/controller/score_service_controller.dart';
import 'package:app_qldt/services/controller/service_controller.dart';
import 'package:app_qldt/services/local/local_service.dart';
import 'package:flutter/widgets.dart';

class LocalScoreService extends LocalService {
  List<ScoreModel> scoreData = [];
  List<SemesterModel> semester = [];

  SemesterModel? get lastSemester => semester.isEmpty ? null : semester[semester.length - 1];

  LocalScoreService({DatabaseProvider? databaseProvider}) : super(databaseProvider);

  Future<List<ScoreModel>> saveNewData(List<ScoreModel> newData) async {
    debugPrint('Score service: Updating new data');

    await _removeOld();
    await _saveNew(newData);

    await _loadScoreDataFromDb();
    await _loadSemesterFromDb();

    connected = true;

    return scoreData;
  }

  @override
  ServiceController<LocalService, ApiService> get serviceController => controller as ScoreServiceController;

  Future<void> _removeOld() async {
    await databaseProvider.score.delete();
  }

  Future<void> _saveNew(List<ScoreModel> rawData) async {
    await databaseProvider.score.insert(rawData);
  }

  Future<void> updateVersion(int? newVersion) async {
    await databaseProvider.dataVersion.updateScoreVersion(newVersion);
  }

  Future<void> loadOldData() async {
    await _loadScoreDataFromDb();
    await _loadSemesterFromDb();
  }

  Future<void> _loadScoreDataFromDb() async {
    final rawData = await databaseProvider.score.all;

    scoreData = rawData.map((data) {
      return ScoreModel.fromMap(data);
    }).toList();
  }

  Future<void> _loadSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await databaseProvider.score.semester;
    final List<SemesterModel> list = [const SemesterModel.all()];

    for (var data in rawData) {
      list.add(SemesterModel(data['semester'].toString()));
    }

    semester = list;
  }
}
