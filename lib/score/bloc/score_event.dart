part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object?> get props => [];
}

class ScorePageStatusChanged extends ScoreEvent {
  final ScorePageStatus status;

  const ScorePageStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class ScoreSemesterChanged extends ScoreEvent {
  final Semester semester;
  final BuildContext context;

  const ScoreSemesterChanged(this.semester, this.context);

  @override
  List<Object?> get props => [semester, context];
}

class ScoreSubjectStatusChanged extends ScoreEvent {
  final SubjectEvaluation subjectEvaluation;
  final BuildContext context;

  const ScoreSubjectStatusChanged(this.subjectEvaluation, this.context);

  @override
  List<Object?> get props => [subjectEvaluation, context];
}

class ScoreDataChanged extends ScoreEvent {
  final BuildContext context;
  final Semester semester;
  final SubjectEvaluation subjectEvaluation;

  const ScoreDataChanged(this.context, this.semester, this.subjectEvaluation);

  @override
  List<Object?> get props => [context, semester, subjectEvaluation];
}

class ScoreDataRefresh extends ScoreEvent {
  const ScoreDataRefresh();
}
