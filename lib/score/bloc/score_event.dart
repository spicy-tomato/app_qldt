part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();
}

class ScoreDataChanged extends ScoreEvent {
  final List<Score> scoreData;

  ScoreDataChanged(this.scoreData);

  @override
  List<Object?> get props => [scoreData];
}

class ScorePageStatusChanged extends ScoreEvent {
  final ScorePageStatus status;

  ScorePageStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class ScoreSemesterChanged extends ScoreEvent {
  final String semester;

  ScoreSemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}
