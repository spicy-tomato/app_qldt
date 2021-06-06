import 'dart:async';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/exam_schedule_model.dart';
import 'package:app_qldt/_services/api/crawler_service.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/exam_schedule/bloc/enum/exam_schedule_page_status.dart';
import 'package:app_qldt/_models/semester_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

export 'enum/exam_schedule_page_status.dart';

part 'exam_schedule_event.dart';

part 'exam_schedule_state.dart';

class ExamScheduleBloc extends Bloc<ExamScheduleEvent, ExamScheduleState> {
  final UserDataModel _userDataModel;
  final CrawlerService _crawlerService;

  ExamScheduleBloc(BuildContext context)
      : _userDataModel = UserDataModel.of(context),
        _crawlerService = CrawlerService(AppModeWidget.of(context).apiUrl),
        super(ExamScheduleInitial(
          examScheduleData: UserDataModel.of(context)
              .examScheduleServiceController
              .getExamScheduleOfSemester(
                  UserDataModel.of(context).examScheduleServiceController.lastSemester),
          semester:
              UserDataModel.of(context).examScheduleServiceController.lastSemester ?? SemesterModel.none(),
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
      examScheduleData:
          _userDataModel.examScheduleServiceController.getExamScheduleOfSemester(event.semester),
    );
  }

  Stream<ExamScheduleState> _mapExamScheduleDataRefreshToState(ExamScheduleDataRefresh event) async* {
    bool canLoadNewData = false;

    yield state.copyWith(status: ExamSchedulePageStatus.loading);

    //  Also request to crawl score
    CrawlerStatus scoreCrawlerStatus = await _crawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: _userDataModel.idStudent,
        idAccount: _userDataModel.idAccount,
      ),
    );
    print('exam_schedule_bloc.dart --- Crawl score: $scoreCrawlerStatus');
    if (scoreCrawlerStatus.isOk){
      await _userDataModel.scoreServiceController.refresh();
    }

    CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: _userDataModel.idStudent,
        idAccount: _userDataModel.idAccount,
      ),
    );
    print('exam_schedule_bloc.dart --- Crawl Exam Schedule: $examScheduleCrawlerStatus');

    if (examScheduleCrawlerStatus.isOk) {
      canLoadNewData = true;
      await _userDataModel.examScheduleServiceController.refresh();

      yield state.copyWith(
        examScheduleData: _userDataModel.examScheduleServiceController.examScheduleData,
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
