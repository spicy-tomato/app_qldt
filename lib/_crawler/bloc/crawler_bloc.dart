import 'dart:async';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_crawler/model/qldt_password_model.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler_model.dart';
import 'package:app_qldt/_models/user_data_model.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_services/api/crawler_service.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'crawler_event.dart';

part 'crawler_state.dart';

class CrawlerBloc extends Bloc<CrawlerEvent, CrawlerState> {
  final BuildContext context;
  final CrawlerService _crawlerService;

  CrawlerBloc(this.context)
      : _crawlerService = CrawlerService(AppModeWidget.of(context).apiUrl),
        super(const CrawlerInitial());

  @override
  Stream<CrawlerState> mapEventToState(
    CrawlerEvent event,
  ) async* {
    if (event is CrawlerPasswordChanged) {
      yield _mapCrawlerPasswordChangedToState(event);
    } else if (event is CrawlerPasswordVisibleChanged) {
      yield _mapCrawlerPasswordVisibleChangedToState(event);
    } else if (event is CrawlerSubmitted) {
      yield* _mapCrawlerSubmittedToState();
    } else if (event is CrawlerDownload) {
      yield* _mapCrawlerDownloadToState();
    } else if (event is CrawlerResetStatus) {
      yield _mapCrawlerResetStatusToState();
    }
  }

  CrawlerState _mapCrawlerPasswordChangedToState(CrawlerPasswordChanged event) {
    final password = QldtPasswordModel.dirty(event.password);
    return state.copyWith(
      status: CrawlerStatus.unknown,
      password: password,
      formStatus: Formz.validate(
        [password],
      ),
    );
  }

  CrawlerState _mapCrawlerPasswordVisibleChangedToState(CrawlerPasswordVisibleChanged event) {
    return state.copyWith(hidePassword: event.hidePassword ?? !state.hidePassword);
  }

  Stream<CrawlerState> _mapCrawlerSubmittedToState() async* {
    if (state.formStatus.isValidated) {
      yield state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
        status: CrawlerStatus.validatingPassword,
      );

      UserDataModel userDataModel = context.read<UserRepository>().userDataModel;
      String idStudent = userDataModel.idUser;
      String idAccount = userDataModel.idAccount;

      final String password = state.password.value;

      CrawlerStatus passwordStatus = await _crawlerService.updatePassword(
        UpdatePasswordCrawlerModel(
          idAccount: idAccount,
          idStudent: idStudent,
          password: password,
        ),
      );

      print('crawler_bloc.dart --- Update password: $passwordStatus');

      if (passwordStatus.isOk) {
        bool hasError = false;

        //  Crawl score
        yield state.copyWith(status: CrawlerStatus.crawlingScore);
        CrawlerStatus scoreCrawlerStatus = await _crawlerService.crawlScore(
          ScoreCrawlerModel(
            idStudent: idStudent,
            idAccount: idAccount,
            all: true,
          ),
        );
        print('crawler_bloc.dart --- Crawl score: $scoreCrawlerStatus');

        if (scoreCrawlerStatus.isOk) {
          await userDataModel.scoreServiceController.refresh();
          userDataModel.scoreServiceController.setConnected();
        } else {
          hasError = true;
        }

        //  Crawl exam schedule
        yield state.copyWith(status: CrawlerStatus.crawlingExamSchedule);
        CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
          ExamScheduleCrawlerModel(
            idStudent: idStudent,
            idAccount: idAccount,
            all: true,
          ),
        );
        print('crawler_bloc.dart --- Crawl exam Schedule: $examScheduleCrawlerStatus');

        if (examScheduleCrawlerStatus.isOk) {
          await userDataModel.examScheduleServiceController.refresh();
          userDataModel.examScheduleServiceController.setConnected();
        } else {
          hasError = true;
        }

        if (hasError) {
          yield state.copyWith(status: CrawlerStatus.errorWhileCrawling);
        } else {
          yield state.copyWith(status: CrawlerStatus.ok);
        }
      } else {
        yield state.copyWith(status: passwordStatus, formStatus: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(
        formStatus: FormzStatus.invalid,
        password: const QldtPasswordModel.dirty(''),
      );
    }
  }

  Stream<CrawlerState> _mapCrawlerDownloadToState() async* {
    yield state.copyWith(
      formStatus: FormzStatus.submissionInProgress,
      status: CrawlerStatus.validatingPassword,
    );

    UserDataModel userDataModel = context.read<UserRepository>().userDataModel;
    String idStudent = userDataModel.idUser;
    String idAccount = userDataModel.idAccount;
    bool hasError = false;

    //  Crawl score
    yield state.copyWith(status: CrawlerStatus.crawlingScore);
    CrawlerStatus scoreCrawlerStatus = await _crawlerService.crawlScore(
      ScoreCrawlerModel(
        idStudent: idStudent,
        idAccount: idAccount,
        all: true,
      ),
    );

    print(state.formStatus);

    print('crawler_bloc.dart --- Crawl score: $scoreCrawlerStatus');

    if (scoreCrawlerStatus.isOk) {
      await userDataModel.scoreServiceController.refresh();
      userDataModel.scoreServiceController.setConnected();
    } else {
      hasError = true;
    }

    //  Crawl exam schedule
    yield state.copyWith(status: CrawlerStatus.crawlingExamSchedule);
    CrawlerStatus examScheduleCrawlerStatus = await _crawlerService.crawlExamSchedule(
      ExamScheduleCrawlerModel(
        idStudent: idStudent,
        idAccount: idAccount,
        all: true,
      ),
    );
    print('crawler_bloc.dart --- Crawl exam Schedule: $examScheduleCrawlerStatus');

    if (examScheduleCrawlerStatus.isOk) {
      await userDataModel.examScheduleServiceController.refresh();
      userDataModel.examScheduleServiceController.setConnected();
    } else {
      hasError = true;
    }

    if (hasError) {
      yield state.copyWith(status: CrawlerStatus.errorWhileCrawling);
    } else {
      yield state.copyWith(status: CrawlerStatus.ok);
    }
  }

  CrawlerState _mapCrawlerResetStatusToState() {
    return state.copyWith(status: CrawlerStatus.unknown);
  }
}
