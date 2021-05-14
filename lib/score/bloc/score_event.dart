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
  final BuildContext context;

  ScoreSemesterChanged(this.semester, this.context);

  @override
  List<Object?> get props => [semester, context];
}

class ScoreSubjectStatusChanged extends ScoreEvent {
  final SubjectEvaluation subjectEvaluation;
  final BuildContext context;

  ScoreSubjectStatusChanged(this.subjectEvaluation, this.context);

  @override
  List<Object?> get props => [subjectEvaluation, context];
}

class ScoreFilterButtonSubmited extends ScoreEvent {
  final BuildContext context;
  final Semester semester;
  final SubjectEvaluation subjectEvaluation;

  const ScoreFilterButtonSubmited(this.context, this.semester, this.subjectEvaluation);

  @override
  List<Object?> get props => [context, semester, subjectEvaluation];
}
