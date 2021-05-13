import 'dart:async';

import 'package:app_qldt/_models/score.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/score/model/semester.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'enum/status.dart';

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
      yield* _mapScoreSemesterChangedToState(event);
    } else if (event is ScoreSubjectStatusChanged) {
      yield _mapScoreSubjectStatusChangedToState(event);
    }
  }

  ScoreState _mapScoreDataChangedToState(ScoreDataChanged event) {
    return state.copyWith(scoreData: event.scoreData);
  }

  ScoreState _mapScorePageStatusChangedToState(ScorePageStatusChanged event) {
    return state.copyWith(status: event.status);
  }

  Stream<ScoreState> _mapScoreSemesterChangedToState(ScoreSemesterChanged event) async* {
    if (event.semester != state.semester) {
      List<Score> newScoreData;

      if (event.semester == Semester.all) {
        newScoreData = UserDataModel.of(event.context)!.localScoreService.scoreData;
      } else {
        newScoreData = UserDataModel.of(event.context)!
            .localScoreService
            .scoreData
            .where((score) => score.semester == event.semester.toString())
            .toList();
      }

      add(ScoreDataChanged(newScoreData));

      yield state.copyWith(semester: event.semester);
    }
  }
}
