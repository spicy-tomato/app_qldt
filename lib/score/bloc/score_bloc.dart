import 'dart:async';

import 'package:app_qldt/_models/score.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'enum/status.dart';

part 'score_event.dart';

part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc(List<Score> scoreData) : super(ScoreState(scoreData: scoreData));

  @override
  Stream<ScoreState> mapEventToState(
    ScoreEvent event,
  ) async* {
    if (event is ScoreDataChanged) {
      yield _mapScoreDataChangedToState(event, state);
    } else if (event is ScorePageStatusChanged) {
      yield _mapScorePageStatusChangedToState(event, state);
    } else if (event is ScoreSemesterChanged) {
      yield _mapScoreSemesterChangedToState(event, state);
    }
  }

  ScoreState _mapScoreDataChangedToState(ScoreDataChanged event, ScoreState state) {
    return state.copyWith(scoreData: event.scoreData);
  }

  ScoreState _mapScorePageStatusChangedToState(ScorePageStatusChanged event, ScoreState state) {
    return state.copyWith(status: event.status);
  }

  ScoreState _mapScoreSemesterChangedToState(ScoreSemesterChanged event, ScoreState state) {
    return state.copyWith(semester: event.semester);
  }
}
