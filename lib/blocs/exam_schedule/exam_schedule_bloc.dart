import 'dart:async';

import 'package:app_qldt/enums/exam_schedule/exam_schedule_page_status.dart';
import 'package:app_qldt/enums/crawl/crawler_status.dart';
import 'package:app_qldt/models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/models/crawler/score_crawler_model.dart';
import 'package:app_qldt/models/exam_schedule/exam_schedule_model.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';
import 'package:app_qldt/services/api/crawler_service.dart';
import 'package:app_qldt/models/service/user_data_model.dart';
import 'package:app_qldt/models/event/semester_model.dart';
import 'package:app_qldt/widgets/wrapper/app_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export '../../enums/exam_schedule/exam_schedule_page_status.dart';

part 'exam_schedule_event.dart';

part 'exam_schedule_state.dart';

class ExamScheduleBloc extends Bloc<ExamScheduleEvent, ExamScheduleState> {
  final UserDataModel _userDataModel;
  final CrawlerService _crawlerService;

  ExamScheduleBloc(BuildContext context)
      : _userDataModel = context.read<UserRepository>().userDataModel,
        _crawlerService = CrawlerService(AppModeWidget.of(context).apiUrl),
        super(ExamScheduleInitial(userDataModel: context.read<UserRepository>().userDataModel));

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
        idStudent: _userDataModel.idUser,
        idAccount: _userDataModel.idAccount,
      ),
    );
    debugPrint('exam_schedule_bloc.dart --- Crawl score: $scoreCrawlerStatus');
    if (scoreCrawlerStatus.isOk) {
      await _userDataModel.scoreServiceController.refresh();
    }

    CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: _userDataModel.idUser,
        idAccount: _userDataModel.idAccount,
      ),
    );
    debugPrint('exam_schedule_bloc.dart --- Crawl Exam Schedule: $examScheduleCrawlerStatus');

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
