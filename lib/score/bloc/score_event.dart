part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object?> get props => [];
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
  final Semester semester;

  ScoreSemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class ScoreSubjectStatusChanged extends ScoreEvent {
  final SubjectEvaluation scoreSubjectStatus;

  ScoreSubjectStatusChanged(this.scoreSubjectStatus);

  @override
  List<Object?> get props => [scoreSubjectStatus];
}

class ScoreFilterButtonSubmited extends ScoreEvent {
  final BuildContext context;

  const ScoreFilterButtonSubmited(this.context);

  @override
  List<Object?> get props => [context];
}
