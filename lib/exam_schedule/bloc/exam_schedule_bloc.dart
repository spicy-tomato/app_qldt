import 'dart:async';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/exam_schedule/bloc/enum/exam_schedule_page_status.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'enum/exam_schedule_page_status.dart';

part 'exam_schedule_event.dart';

part 'exam_schedule_state.dart';

class ExamScheduleBloc extends Bloc<ExamScheduleEvent, ExamScheduleState> {
  final UserDataModel userDataModel;

  ExamScheduleBloc(this.userDataModel)
      : super(ExamScheduleInitial(
          examScheduleData: userDataModel.localExamScheduleService
              .getExamScheduleOfSemester(userDataModel.localExamScheduleService.lastSemester!),
          semester: userDataModel.localExamScheduleService.lastSemester!,
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
    } else if (event is ExamSchedulePageStatusChanged) {
      yield _mapScorePageStatusChangedToState(event);
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
      examScheduleData: userDataModel.localExamScheduleService.getExamScheduleOfSemester(event.semester),
    );
  }

  Stream<ExamScheduleState> _mapExamScheduleDataRefreshToState(ExamScheduleDataRefresh event) async* {
    bool canLoadNewData = false;

    yield state.copyWith(status: ExamSchedulePageStatus.loading);

    CrawlerStatus examScheduleCrawlerStatus = await CrawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: userDataModel.idStudent,
        idAccount: userDataModel.idAccount,
      ),
    );
    print('exam_schedule_bloc.dart --- Crawl Exam Schedule: $examScheduleCrawlerStatus');

    //  Also request to crawl score
    CrawlerStatus scoreCrawlerStatus = await CrawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: userDataModel.idStudent,
        idAccount: userDataModel.idAccount,
      ),
    );
    print('exam_schedule_bloc.dart --- Crawl score: $scoreCrawlerStatus');

    if (examScheduleCrawlerStatus.isOk) {
      canLoadNewData = true;
      yield state.copyWith(
        examScheduleData: await userDataModel.localExamScheduleService.refresh(),
        status: ExamSchedulePageStatus.successfully,
      );
    }

    if (!canLoadNewData) {
      yield state.copyWith(status: ExamSchedulePageStatus.failed);
    }
  }

  ExamScheduleState _mapScorePageStatusChangedToState(ExamSchedulePageStatusChanged event) {
    return state.copyWith(status: event.status);
  }
}
