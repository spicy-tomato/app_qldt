part of 'score_bloc.dart';

class ScoreState extends Equatable {
  final List<ScoreModel> scoreData;
  final ScorePageStatus status;
  final SemesterModel semester;
  final SubjectEvaluation subjectEvaluation;
  final ScoreType scoreType;

  const ScoreState({
    required this.scoreData,
    required this.status,
    required this.semester,
    required this.subjectEvaluation,
    required this.scoreType,
  });

  ScoreState copyWith(
      {List<ScoreModel>? scoreData,
      ScorePageStatus? status,
      SemesterModel? semester,
      SubjectEvaluation? subjectEvaluation,
      ScoreType? scoreType}) {
    return ScoreState(
      scoreData: scoreData ?? this.scoreData,
      status: status ?? this.status,
      semester: semester ?? this.semester,
      subjectEvaluation: subjectEvaluation ?? this.subjectEvaluation,
      scoreType: scoreType ?? this.scoreType,
    );
  }

  @override
  List<Object?> get props => [
        scoreData,
        status,
        semester,
        subjectEvaluation,
        scoreType,
      ];
}

class ScoreInitialState extends ScoreState {
  ScoreInitialState(List<ScoreModel> scoreData)
      : super(
          scoreData: scoreData,
          status: ScorePageStatus.unknown,
          semester: const SemesterModel(),
          subjectEvaluation: SubjectEvaluation.all,
          scoreType: ScoreType.moduleScore,
        );
}
