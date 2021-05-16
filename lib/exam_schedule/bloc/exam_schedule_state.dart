part of 'exam_schedule_bloc.dart';

class ExamScheduleState extends Equatable {
  final List<ExamSchedule> examScheduleData;
  final ExamSchedulePageStatus status;
  final Semester semester;

  const ExamScheduleState({
    required this.examScheduleData,
    required this.status,
    required this.semester,
  });

  ExamScheduleState copyWith({
    List<ExamSchedule>? examScheduleData,
    ExamSchedulePageStatus? status,
    Semester? semester,
  }) {
    return ExamScheduleState(
      examScheduleData: examScheduleData ?? this.examScheduleData,
      status: status ?? this.status,
      semester: semester ?? this.semester,
    );
  }

  @override
  List<Object> get props => [
        examScheduleData,
        status,
        semester,
      ];
}

class ExamScheduleInitial extends ExamScheduleState {
  const ExamScheduleInitial({
    required List<ExamSchedule> examScheduleData,
    required Semester semester,
  }) : super(
          examScheduleData: examScheduleData,
          status: ExamSchedulePageStatus.done,
          semester: semester,
        );
}
