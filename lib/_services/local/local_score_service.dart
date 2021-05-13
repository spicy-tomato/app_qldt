import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_services/web/score_service.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/score/model/semester.dart';

class LocalScoreService {
  final String? userId;
  late DatabaseProvider _databaseProvider;
  late final ScoreService _scoreService;

  List<Score> scoreData = [];
  List<Semester> semester = [];

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

  Future<List<Semester>> _getSemesterFromDb() async {
    final List<Map<String, dynamic>> rawData = await _databaseProvider.score.semester;
    final List<Semester> list = [Semester.all];

    rawData.forEach((data) {
      list.add(Semester(data['semester'].toString()));
    });

    return list;
  }

  static LocalScoreService get instance => LocalScoreService();
}
