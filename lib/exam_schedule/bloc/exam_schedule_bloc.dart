import 'dart:async';

import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/exam_schedule/bloc/enum/exam_schedule_page_status.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

export 'enum/exam_schedule_page_status.dart';

part 'exam_schedule_event.dart';

part 'exam_schedule_state.dart';

class ExamScheduleBloc extends Bloc<ExamScheduleEvent, ExamScheduleState> {
  final BuildContext context;

  ExamScheduleBloc(this.context)
      : super(ExamScheduleInitial(
          examScheduleData: UserDataModel.of(context).localExamScheduleService.examScheduleData,
          semester: UserDataModel.of(context).localExamScheduleService.lastSemester!,
        ));

  @override
  Stream<ExamScheduleState> mapEventToState(
    ExamScheduleEvent event,
  ) async* {
    if (event is ExamScheduleSemesterChanged) {
      yield* _mapExamSchedulePageSemesterChangedToState(event);
    } else if (event is ExamScheduleDataChanged) {
      yield _mapExamScheduleDataChangedToState(event);
    } else if (event is ExamScheduleDataRefresh) {
      yield* _mapExamScheduleDataRefreshToState(event);
    }
  }

  Stream<ExamScheduleState> _mapExamSchedulePageSemesterChangedToState(
      ExamScheduleSemesterChanged event) async* {
    if (event.semester != state.semester) {
      yield _mapExamScheduleDataChangedToState(ExamScheduleDataChanged(event.semester));
    }
  }

  ExamScheduleState _mapExamScheduleDataChangedToState(ExamScheduleDataChanged event) {
    return state.copyWith(
      semester: event.semester,
      examScheduleData: UserDataModel.of(context)
          .localExamScheduleService
          .getExamScheduleOfSemester(event.semester),
    );
  }

  Stream<ExamScheduleState> _mapExamScheduleDataRefreshToState(
      ExamScheduleDataRefresh event) async* {
    yield state.copyWith(status: ExamSchedulePageStatus.loading);

    List<ExamScheduleModel> newScoreData =
        (await UserDataModel.of(context).localExamScheduleService.refresh())!;

    yield state.copyWith(
      examScheduleData: newScoreData,
      status: ExamSchedulePageStatus.done,
    );
  }
}
