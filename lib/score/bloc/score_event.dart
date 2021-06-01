part of 'score_bloc.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object?> get props => [];
}

class ScoreSemesterChanged extends ScoreEvent {
  final SemesterModel semester;

  const ScoreSemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class ScoreSubjectStatusChanged extends ScoreEvent {
  final SubjectEvaluation subjectEvaluation;

  const ScoreSubjectStatusChanged(this.subjectEvaluation);

  @override
  List<Object?> get props => [subjectEvaluation];
}

class ScoreDataChanged extends ScoreEvent {
  final SemesterModel semester;
  final SubjectEvaluation subjectEvaluation;

  const ScoreDataChanged(this.semester, this.subjectEvaluation);

  @override
  List<Object?> get props => [semester, subjectEvaluation];
}

class ScoreDataRefresh extends ScoreEvent {
  const ScoreDataRefresh();
}

class ScorePageStatusChanged extends ScoreEvent {
  final ScorePageStatus status;

  const ScorePageStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}

class ScoreTypeChanged extends ScoreEvent {
  final ScoreType type;

  const ScoreTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}
