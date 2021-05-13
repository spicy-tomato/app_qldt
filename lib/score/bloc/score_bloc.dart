import 'dart:async';

import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/bloc/enum/subject_status.dart';
import 'package:app_qldt/score/model/semester.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'enum/page_status.dart';

part 'score_event.dart';

part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc(BuildContext context) : super(ScoreInitialState(context));

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is ScoreDataChanged) {
      yield _mapScoreDataChangedToState(event);
    } else if (event is ScorePageStatusChanged) {
      yield _mapScorePageStatusChangedToState(event);
    } else if (event is ScoreSemesterChanged) {
      yield _mapScoreSemesterChangedToState(event);
    } else if (event is ScoreSubjectStatusChanged) {
      yield _mapScoreSubjectStatusChangedToState(event);
    } else if (event is ScoreFilterButtonSubmited) {
      yield* _mapScoreFilterButtonSubmitedToState(event);
    }
  }

  ScoreState _mapScoreDataChangedToState(ScoreDataChanged event) {
    return state.copyWith(scoreData: event.scoreData);
  }

  ScoreState _mapScorePageStatusChangedToState(ScorePageStatusChanged event) {
    return state.copyWith(status: event.status);
  }

  Stream<ScoreState> _mapScoreFilterButtonSubmitedToState(ScoreFilterButtonSubmited event) async* {
    List<Score> newScoreData = [];
    LocalScoreService scoreService = UserDataModel.of(event.context)!.localScoreService;

    //  Query all
    if (state.semester == Semester.all && state.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreService.scoreData;
    }
    //  Query a specific semester with all subject status
    else if (state.subjectEvaluation == SubjectEvaluation.all) {
      newScoreData = scoreService.getScoreDataOfAllEvaluation(state.semester);
    }
    //  Query all semester with a specific subject status
    else if (state.semester == Semester.all) {
      newScoreData = scoreService.getScoreDataOfAllSemester(state.subjectEvaluation);
    }
    //  Query a specific semester with a specific subject status
    else {
      newScoreData = scoreService.getSpecificScoreData(state.semester, state.subjectEvaluation);
    }

    yield state.copyWith(scoreData: newScoreData);
  }

  ScoreState _mapScoreSemesterChangedToState(ScoreSemesterChanged event) {
    return state.copyWith(semester: event.semester);
  }

  ScoreState _mapScoreSubjectStatusChangedToState(ScoreSubjectStatusChanged event) {
    return state.copyWith(subjectEvaluation: event.scoreSubjectStatus);
  }
}
