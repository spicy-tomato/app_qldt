part of 'score_models.dart';

class GpaTotalScore {
  double gpa10;
  double gpa4;
  int credit;

  GpaTotalScore({
    this.gpa10 = 0,
    this.gpa4 = 0,
    this.credit = 0,
  });
}

extension ScoreExtension on double {
  double toGpa4() {
    if (this <= 1.9) {
      return 0;
    } else if (this <= 3.9) {
      return 0.5;
    } else if (this <= 4.4) {
      return 1;
    } else if (this <= 5.4) {
      return 1.5;
    } else if (this <= 5.9) {
      return 2;
    } else if (this <= 6.9) {
      return 2.5;
    } else if (this <= 7.9) {
      return 3;
    } else if (this <= 8.4) {
      return 3.5;
    } else if (this <= 9.4) {
      return 3.8;
    } else {
      return 4;
    }
  }
}
