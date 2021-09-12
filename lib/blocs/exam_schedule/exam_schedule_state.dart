part of 'exam_schedule_bloc.dart';

class ExamScheduleState extends Equatable {
  final List<ExamScheduleModel> examScheduleData;
  final ExamSchedulePageStatus status;
  final SemesterModel semester;

  const ExamScheduleState({
    required this.examScheduleData,
    required this.status,
    required this.semester,
  });

  ExamScheduleState copyWith({
    List<ExamScheduleModel>? examScheduleData,
    ExamSchedulePageStatus? status,
    SemesterModel? semester,
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
  ExamScheduleInitial({
    required UserDataModel userDataModel,
  }) : super(
          examScheduleData: userDataModel.examScheduleServiceController.getExamScheduleOfLastSemester(),
          semester: userDataModel.examScheduleServiceController.lastSemester ?? const SemesterModel.none(),
          status: ExamSchedulePageStatus.unknown,
        );
}
