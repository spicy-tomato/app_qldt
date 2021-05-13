enum SubjectEvaluation {
  all,
  pass,
  fail,
}

extension SubjectStatusExtension on SubjectEvaluation {
  static String stringFunction(SubjectEvaluation status){
    return status.string;
  }

  String get string {
    switch (this) {
      case SubjectEvaluation.pass:
        return 'DAT';

      case SubjectEvaluation.fail:
        return 'HOCLAI';

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
