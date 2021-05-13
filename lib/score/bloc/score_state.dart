part of 'score_bloc.dart';

class ScoreState extends Equatable {
  final List<Score> scoreData;
  final ScorePageStatus status;
  final Semester semester;
  final SubjectEvaluation subjectEvaluation;

  const ScoreState({
    required this.scoreData,
    this.status = ScorePageStatus.done,
    this.semester = const Semester(),
    this.subjectEvaluation = SubjectEvaluation.all,
  });

  ScoreState copyWith({
    List<Score>? scoreData,
    ScorePageStatus? status,
    Semester? semester,
    SubjectEvaluation? subjectEvaluation,
  }) {
    return ScoreState(
      scoreData: scoreData ?? this.scoreData,
      status: status ?? this.status,
      semester: semester ?? this.semester,
      subjectEvaluation: subjectEvaluation ?? this.subjectEvaluation,
    );
  }

  @override
  List<Object?> get props => [
        scoreData,
        status,
        semester,
        subjectEvaluation,
      ];
}

class ScoreInitialState extends ScoreState {
  ScoreInitialState(BuildContext context)
      : super(scoreData: UserDataModel.of(context)!.localScoreService.scoreData);
}
