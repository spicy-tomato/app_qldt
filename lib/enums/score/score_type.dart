part of 'score_enum.dart';

enum ScoreType {
  moduleScore,
  gpaScore,
}

extension ScoreTypeExtension on ScoreType {
  bool get isModuleScore => this == ScoreType.moduleScore;

  static String stringFunction(ScoreType status) {
    return status.string;
  }

  String get string {
    switch (this) {
      case ScoreType.moduleScore:
        return 'Điểm học phần';

      default:
        return 'Điểm trung bình tích luỹ';
    }
  }
}
