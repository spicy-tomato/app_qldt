import 'dart:async';

import 'package:app_qldt/enums/score/score_enum.dart';
import 'package:app_qldt/models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/models/crawler/score_crawler_model.dart';
import 'package:app_qldt/models/event/semester_model.dart';
import 'package:app_qldt/models/score/score_models.dart';
import 'package:app_qldt/models/service/user_data_model.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';
import 'package:app_qldt/services/api/crawler_service.dart';
import 'package:app_qldt/services/controller/score_service_controller.dart';
import 'package:app_qldt/widgets/wrapper/_crawler/crawler.dart';
import 'package:app_qldt/widgets/wrapper/app_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:app_qldt/enums/score/score_enum.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final UserDataModel _userDataModel;
  final CrawlerService _crawlerService;

  ScoreBloc(BuildContext context)
      : _userDataModel = context.read<UserRepository>().userDataModel,
        _crawlerService = CrawlerService(AppModeWidget.of(context).apiUrl),
        super(ScoreInitialState(userDataModel: context.read<UserRepository>().userDataModel));

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is ScoreSemesterChanged) {
      yield* _mapScoreSemesterChangedToState(event);
    } else if (event is ScoreSubjectStatusChanged) {
      yield* _mapScoreSubjectStatusChangedToState(event);
    } else if (event is ScoreDataChanged) {
      yield _mapScoreDataChangedToState(event);
    } else if (event is ScoreDataRefresh) {
      yield* _mapScoreDataRefreshToState();
    } else if (event is ScorePageStatusChanged) {
      yield _mapScorePageStatusChangedToState(event);
    } else if (event is ScoreTypeChanged) {
      yield _mapScoreTypeChangedToState(event);
    }
  }

  Stream<ScoreState> _mapScoreSemesterChangedToState(ScoreSemesterChanged event) async* {
    if (event.semester != state.semester) {
      yield _mapScoreDataChangedToState(ScoreDataChanged(event.semester, state.subjectEvaluation));
    }
  }

  Stream<ScoreState> _mapScoreSubjectStatusChangedToState(ScoreSubjectStatusChanged event) async* {
    if (event.subjectEvaluation != state.subjectEvaluation) {
      yield _mapScoreDataChangedToState(ScoreDataChanged(state.semester, event.subjectEvaluation));
    }
  }

  ScoreState _mapScoreDataChangedToState(ScoreDataChanged event) {
    List<ScoreModel> newScoreData = [];
    final ScoreServiceController scoreServiceController = _userDataModel.scoreServiceController;

    //  Query all
    if (event.semester == const SemesterModel.all() && event.subjectEvaluation.isAll) {
      newScoreData = scoreServiceController.scoreData;
    }
    //  Query a specific semester with all subject status
    else if (event.subjectEvaluation.isAll) {
      newScoreData = scoreServiceController.getScoreDataOfAllEvaluation(event.semester);
    }
    //  Query all semester with a specific subject status
    else if (event.semester == const SemesterModel.all()) {
      newScoreData = scoreServiceController.getScoreDataOfAllSemester(event.subjectEvaluation);
    }
    //  Query a specific semester with a specific subject status
    else {
      newScoreData = scoreServiceController.getSpecificScoreData(event.semester, event.subjectEvaluation);
    }

    return state.copyWith(
      scoreData: newScoreData,
      semester: event.semester,
      subjectEvaluation: event.subjectEvaluation,
    );
  }

  Stream<ScoreState> _mapScoreDataRefreshToState() async* {
    bool canLoadNewData = false;

    yield state.copyWith(status: ScorePageStatus.loading);

    final CrawlerStatus scoreCrawlerStatus = await _crawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: _userDataModel.idUser,
        idAccount: _userDataModel.idAccount,
      ),
    );
    debugPrint('score_bloc.dart --- Crawl score: $scoreCrawlerStatus');

    //  Also request to crawl exam schedule
    final CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: _userDataModel.idUser,
        idAccount: _userDataModel.idAccount,
      ),
    );
    debugPrint('score_bloc.dart --- Crawl exam Schedule: $examScheduleCrawlerStatus');
    if (examScheduleCrawlerStatus.isOk) {
      await _userDataModel.examScheduleServiceController.refresh();
    }

    if (scoreCrawlerStatus.isOk) {
      canLoadNewData = true;
      await _userDataModel.scoreServiceController.refresh();

      yield state.copyWith(
        status: ScorePageStatus.successfully,
        scoreData: _userDataModel.scoreServiceController.getSpecificScoreData(state.semester, state.subjectEvaluation),
      );
    }

    if (!canLoadNewData) {
      yield state.copyWith(status: ScorePageStatus.failed);
    }
  }

  ScoreState _mapScorePageStatusChangedToState(ScorePageStatusChanged event) {
    return state.copyWith(status: event.status);
  }

  ScoreState _mapScoreTypeChangedToState(ScoreTypeChanged event) {
    if (event.type == ScoreType.gpaScore) {
      return state.copyWith(
        scoreData: _userDataModel.scoreServiceController.getGpaModulesData(),
        scoreType: event.type,
      );
    }

    return state.copyWith(
      scoreType: event.type,
      scoreData: _userDataModel.scoreServiceController.getSpecificScoreData(state.semester, state.subjectEvaluation),
    );
  }
}
