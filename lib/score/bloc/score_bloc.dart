import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_services/api/crawler_service.dart';
import 'package:app_qldt/_services/controller/score_service_controller.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';
import 'package:app_qldt/_models/user_data_model.dart';
import 'package:app_qldt/score/bloc/enum/score_type.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/_models/semester_model.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enum/score_page_status.dart';
export 'enum/score_page_status.dart';

part 'score_event.dart';

part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final UserDataModel _userDataModel;
  final CrawlerService _crawlerService;

  ScoreBloc(BuildContext context)
      : _userDataModel = context.read<UserRepository>().userDataModel,
        _crawlerService = CrawlerService(AppModeWidget.of(context).apiUrl),
        super(ScoreInitialState(
            context.read<UserRepository>().userDataModel.scoreServiceController.scoreData));

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
      yield* _mapScoreTypeChangedToState(event);
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
    ScoreServiceController scoreServiceController = _userDataModel.scoreServiceController;

    //  Query all
    if (event.semester == SemesterModel.all() && event.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreServiceController.scoreData;
    }
    //  Query a specific semester with all subject status
    else if (event.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreServiceController.getScoreDataOfAllEvaluation(event.semester);
    }
    //  Query all semester with a specific subject status
    else if (event.semester == SemesterModel.all()) {
      newScoreData = scoreServiceController.getScoreDataOfAllSemester(event.subjectEvaluation);
    }
    //  Query a specific semester with a specific subject status
    else {
      newScoreData =
          scoreServiceController.getSpecificScoreData(event.semester, event.subjectEvaluation);
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

    CrawlerStatus scoreCrawlerStatus = await _crawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: _userDataModel.idStudent,
        idAccount: _userDataModel.idAccount,
      ),
    );
    print('score_bloc.dart --- Crawl score: $scoreCrawlerStatus');

    //  Also request to crawl exam schedule
    CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: _userDataModel.idStudent,
        idAccount: _userDataModel.idAccount,
      ),
    );
    print('score_bloc.dart --- Crawl exam Schedule: $examScheduleCrawlerStatus');
    if (examScheduleCrawlerStatus.isOk) {
      await _userDataModel.examScheduleServiceController.refresh();
    }

    if (scoreCrawlerStatus.isOk) {
      canLoadNewData = true;
      await _userDataModel.scoreServiceController.refresh();

      yield state.copyWith(
        scoreData: _userDataModel.scoreServiceController.scoreData,
        status: ScorePageStatus.successfully,
      );
    }

    if (!canLoadNewData) {
      yield state.copyWith(status: ScorePageStatus.failed);
    }
  }

  ScoreState _mapScorePageStatusChangedToState(ScorePageStatusChanged event) {
    return state.copyWith(status: event.status);
  }

  Stream<ScoreState> _mapScoreTypeChangedToState(ScoreTypeChanged event) async* {
    if (state.scoreType != event.type) {
      if (event.type == ScoreType.gpaScore) {
        yield state.copyWith(
          scoreData: _userDataModel.scoreServiceController.getGpaModulesData(),
          scoreType: event.type,
        );
      } else {
        yield state.copyWith(
          scoreData: _userDataModel.scoreServiceController.scoreData,
          scoreType: event.type,
        );
      }
    }
  }
}
