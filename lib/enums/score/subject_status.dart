part of 'score_enum.dart';

enum SubjectEvaluation {
  all,
  pass,
  fail,
}

extension SubjectStatusExtension on SubjectEvaluation {
  bool get isAll => this == SubjectEvaluation.all;

  bool get isPass => this == SubjectEvaluation.pass;

  bool get isFail => this == SubjectEvaluation.fail;

  static String stringFunction(SubjectEvaluation status) {
    return status.string;
  }

  String get string {
    switch (this) {
      case SubjectEvaluation.pass:
        return 'Đạt';

      case SubjectEvaluation.fail:
        return 'Chưa đạt';

      default:
        return 'Tất cả';
    }
  }

  String get query {
    switch (this) {
      case SubjectEvaluation.pass:
        return 'DAT';

      case SubjectEvaluation.fail:
        return 'HOCLAI';

      default:
        return '';
    }
  }
}
