part of 'exam_schedule_bloc.dart';

abstract class ExamScheduleEvent extends Equatable {
  const ExamScheduleEvent();

  @override
  List<Object?> get props => [];
}

class ExamScheduleSemesterChanged extends ExamScheduleEvent {
  final SemesterModel semester;

  const ExamScheduleSemesterChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class ExamScheduleDataChanged extends ExamScheduleEvent {
  final SemesterModel semester;

  const ExamScheduleDataChanged(this.semester);

  @override
  List<Object?> get props => [semester];
}

class ExamScheduleDataRefresh extends ExamScheduleEvent {}

class ExamSchedulePageStatusChanged extends ExamScheduleEvent {
  final ExamSchedulePageStatus status;

  const ExamSchedulePageStatusChanged(this.status);

  @override
  List<Object?> get props => [status];
}
