import 'dart:async';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/_models/semester_model.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'enum/score_page_status.dart';

export 'enum/score_page_status.dart';

part 'score_event.dart';

part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final BuildContext context;

  ScoreBloc(this.context)
      : super(ScoreInitialState(UserDataModel.of(context).localScoreService.scoreData));

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
    LocalScoreService scoreService = UserDataModel.of(context).localScoreService;

    //  Query all
    if (event.semester == SemesterModel.all && event.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreService.scoreData;
    }
    //  Query a specific semester with all subject status
    else if (event.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreService.getScoreDataOfAllEvaluation(event.semester);
    }
    //  Query all semester with a specific subject status
    else if (event.semester == SemesterModel.all) {
      newScoreData = scoreService.getScoreDataOfAllSemester(event.subjectEvaluation);
    }
    //  Query a specific semester with a specific subject status
    else {
      newScoreData = scoreService.getSpecificScoreData(event.semester, event.subjectEvaluation);
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

    CrawlerStatus scoreCrawlerStatus = await CrawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: UserDataModel.of(context).idStudent,
        idAccount: UserDataModel.of(context).idAccount,
      ),
    );
    print('score_bloc.dart --- Crawl score: $scoreCrawlerStatus');

    if (scoreCrawlerStatus.isOk) {
      canLoadNewData = true;
      yield state.copyWith(
        scoreData: await UserDataModel.of(context).localScoreService.refresh(),
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
}
