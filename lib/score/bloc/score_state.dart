part of 'score_bloc.dart';

class ScoreState extends Equatable {
  final List<ScoreModel> scoreData;
  final ScorePageStatus status;
  final SemesterModel semester;
  final SubjectEvaluation subjectEvaluation;

  const ScoreState({
    required this.scoreData,
    required this.status,
    required this.semester,
    required this.subjectEvaluation,
  });

  ScoreState copyWith({
    List<ScoreModel>? scoreData,
    ScorePageStatus? status,
    SemesterModel? semester,
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
  ScoreInitialState(List<ScoreModel> scoreData)
      : super(
          scoreData: scoreData,
          status: ScorePageStatus.done,
          semester: const SemesterModel(),
          subjectEvaluation: SubjectEvaluation.all,
        );
}
