import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/_crawler/model/password.dart';
import 'package:app_qldt/_models/crawler/score_crawler.dart';
import 'package:app_qldt/_models/crawler/update_password_crawler.dart';
import 'package:app_qldt/_services/web/crawler_service.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'crawler_event.dart';

part 'crawler_state.dart';

class CrawlerBloc extends Bloc<CrawlerEvent, CrawlerState> {
  final BuildContext context;

  CrawlerBloc(this.context) : super(CrawlerInitial());

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
    final password = Password.dirty(event.password);
    return state.copyWith(
      status: CrawlerStatus.unknown,
      password: password,
      formStatus: Formz.validate(
        [password],
      ),
    );
  }

  CrawlerState _mapCrawlerPasswordVisibleChangedToState(CrawlerPasswordVisibleChanged event) {
    return state.copyWith(hidePassword: event.hidePassword);
  }

  Stream<CrawlerState> _mapCrawlerSubmittedToState(CrawlerSubmitted event) async* {
    if (state.formStatus.isValidated) {
      yield state.copyWith(formStatus: FormzStatus.submissionInProgress);

      final Map<String, dynamic> userInfo =
          jsonDecode((await SharedPreferences.getInstance()).getString('user_info')!);

      final String idStudent = userInfo['ID_Student'];
      final String idAccount = userInfo['ID'];
      final String password = state.password.value;

      CrawlerStatus passwordStatus = await CrawlerService.updatePassword(
        UpdatePasswordCrawler(
          idStudent: idStudent,
          idAccount: idAccount,
          password: password,
        ),
      );

      print('crawler_bloc.dart --- Update password: $passwordStatus');

      if (passwordStatus.isOk) {
        CrawlerStatus scoreCrawlerStatus = await CrawlerService.crawlScore(
          ScoreCrawler(
            idStudent: idStudent,
            idAccount: idAccount,
          ),
        );

        if (scoreCrawlerStatus.isOk) {
          print('crawler_bloc.dart --- Crawl score: $scoreCrawlerStatus');

          await UserDataModel.of(context).localScoreService.refresh();

          yield state.copyWith(status: CrawlerStatus.ok);
          UserDataModel.of(context).localScoreService.connected = true;
          return;
        }
      }

      yield state.copyWith(status: passwordStatus, formStatus: FormzStatus.submissionFailure);
    } else {
      yield state.copyWith(
        formStatus: FormzStatus.invalid,
        password: Password.dirty(''),
      );
    }
  }

  CrawlerState _mapCrawlerResetStatusToState() {
    return state.copyWith(status: CrawlerStatus.unknown);
  }
}
