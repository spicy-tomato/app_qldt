import 'dart:async';

import 'package:app_qldt/_crawler/crawler.dart';
import 'package:app_qldt/_crawler/model/qldt_password_model.dart';
import 'package:app_qldt/_models/crawler/exam_schedule_crawler_model.dart';
import 'package:app_qldt/_models/crawler/score_crawler_model.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler_model.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'crawler_event.dart';

part 'crawler_state.dart';

class CrawlerBloc extends Bloc<CrawlerEvent, CrawlerState> {
  final BuildContext context;
  final String idStudent;
  final String idAccount;

  CrawlerBloc(
    this.context, {
    required this.idStudent,
    required this.idAccount,
  }) : super(CrawlerInitial());

  @override
  Stream<CrawlerState> mapEventToState(
    CrawlerEvent event,
  ) async* {
    if (event is CrawlerPasswordChanged) {
      yield _mapCrawlerPasswordChangedToState(event);
    } else if (event is CrawlerPasswordVisibleChanged) {
      yield _mapCrawlerPasswordVisibleChangedToState(event);
    } else if (event is CrawlerSubmitted) {
      yield* _mapCrawlerSubmittedToState(event);
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

  Stream<CrawlerState> _mapCrawlerSubmittedToState(CrawlerSubmitted event) async* {
    if (state.formStatus.isValidated) {
      yield state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
        status: CrawlerStatus.validatingPassword,
      );

      final String password = state.password.value;

      CrawlerStatus passwordStatus = await CrawlerService.updatePassword(
        UpdatePasswordCrawlerModel(
          idStudent: idStudent,
          idAccount: idAccount,
          password: password,
        ),
      );

      print('crawler_bloc.dart --- Update password: $passwordStatus');

      if (passwordStatus.isOk) {
        //  Crawl score
        yield state.copyWith(status: CrawlerStatus.crawlingScore);
        CrawlerStatus scoreCrawlerStatus = await CrawlerService.crawlScore(
          ScoreCrawlerModel(
            idStudent: idStudent,
            idAccount: idAccount,
          ),
        );

        print('crawler_bloc.dart --- Crawl score: $scoreCrawlerStatus');
        if (scoreCrawlerStatus.isOk) {
          await UserDataModel.of(context).localScoreService.refresh();
          UserDataModel.of(context).localScoreService.connected = true;
        }

        //  Crawl exam schedule
        yield state.copyWith(status: CrawlerStatus.crawlingExamSchedule);
        CrawlerStatus examScheduleCrawlerStatus = await CrawlerService.crawlExamSchedule(
          ExamScheduleCrawlerModel(
            idStudent: idStudent,
            idAccount: idAccount,
          ),
        );

        if (examScheduleCrawlerStatus.isOk) {
          print('crawler_bloc.dart --- Crawl exam Schedule: $examScheduleCrawlerStatus');

          await UserDataModel.of(context).localExamScheduleService.refresh();

          yield state.copyWith(status: CrawlerStatus.ok);
          UserDataModel.of(context).localExamScheduleService.connected = true;
          return;
        }
      }

      yield state.copyWith(status: passwordStatus, formStatus: FormzStatus.submissionFailure);
    } else {
      yield state.copyWith(
        formStatus: FormzStatus.invalid,
        password: QldtPasswordModel.dirty(''),
      );
    }
  }

  CrawlerState _mapCrawlerResetStatusToState() {
    return state.copyWith(status: CrawlerStatus.unknown);
  }
}
