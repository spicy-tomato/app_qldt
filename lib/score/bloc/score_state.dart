part of 'score_bloc.dart';

class ScoreState extends Equatable {
  final List<Score> scoreData;
  final ScorePageStatus status;
  final String semester;

  const ScoreState({
    required this.scoreData,
    this.status = ScorePageStatus.done,
    this.semester = '',
  });

  ScoreState copyWith({
    List<Score>? scoreData,
    ScorePageStatus? status,
    String? semester,
  }) {
    return ScoreState(
      scoreData: scoreData ?? this.scoreData,
      status: status ?? this.status,
      semester: semester ?? this.semester,
    );
  }

  @override
  List<Object?> get props => [
        scoreData,
        status,
        semester,
      ];
}

class ScoreInitialState extends ScoreState {
  ScoreInitialState(BuildContext context)
      : super(scoreData: UserDataModel.of(context)!.localScoreService.scoreData);
}
