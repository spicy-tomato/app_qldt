enum ExamSchedulePageStatus {
  unknown,
  successfully,
  failed,
  loading,
}

extension ExamSchedulePageStatusExtension on ExamSchedulePageStatus {
  bool get isLoading => this == ExamSchedulePageStatus.loading;

  bool get isFailed => this == ExamSchedulePageStatus.failed;

  bool get isSuccess => this == ExamSchedulePageStatus.successfully;
}
