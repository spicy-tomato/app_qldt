part of 'score_enum.dart';

enum ScorePageStatus {
  unknown,
  successfully,
  failed,
  loading,
}

extension ScorePageStatusExtension on ScorePageStatus {
  bool get isLoading => this == ScorePageStatus.loading;

  bool get isFailed => this == ScorePageStatus.failed;

  bool get isSuccess => this == ScorePageStatus.successfully;
}
