import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_services/web/score_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';

class LocalScoreService {
  final String? userId;
  late DatabaseProvider _databaseProvider;
  late final ScoreService _scoreService;

  List<Score> scoreData = [];
  List<String> semester = [];

  LocalScoreService({DatabaseProvider? databaseProvider, this.userId}) {
    this._databaseProvider = databaseProvider ?? DatabaseProvider();

    if (userId != null) {
      _scoreService = ScoreService(userId!);
    }
  }

  Future<List<Score>> refresh() async {
    List<Score>? data = await _scoreService.getScore();

    if (data != null) {
      await removeOld();
      await _saveNew(data);
    }

    scoreData = await _getScoreDataFromDb();
    semester = await _getSemesterFromDb();

    return this.scoreData;
  }

  Future<void> _saveNew(List<Score> rawData) async {
    for (var row in rawData) {
      await _databaseProvider.score.insert(row.toMap());
    }
  }

  Future<void> removeOld() async {
    await _databaseProvider.score.delete();
  }

  Future<List<Score>> _getScoreDataFromDb() async {
    final rawData = await _databaseProvider.score.all;

    return rawData.map((data) {
      return Score.fromMap(data);
    }).toList();
  }

  Future<List<String>> _getSemesterFromDb() async {
    final rawData = await _databaseProvider.score.semester;

    return rawData.map((data) {
      return data['semester'].toString();
    }).toList();
  }

  static LocalScoreService get instance => LocalScoreService();
}
