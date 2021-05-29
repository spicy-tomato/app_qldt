import 'dart:async';

import 'package:app_qldt/_models/score_model.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/_models/semester_model.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'enum/page_status.dart';

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
    yield state.copyWith(status: ScorePageStatus.loading);


    List<ScoreModel>? newScoreData = await UserDataModel.of(context).localScoreService.refresh();

    if (newScoreData != null) {
      yield state.copyWith(
        scoreData: newScoreData,
        status: ScorePageStatus.done,
      );
    } else {
      // TODO: Alert when cannot refresh
    }
  }
}
