import 'dart:async';

import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_repositories/user_repository/src/models/user.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_services/api/token_service.dart';
import 'package:app_qldt/_services/api/version_service.dart';
import 'package:app_qldt/_services/controller/event_service_controller.dart';
import 'package:app_qldt/_services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/_services/controller/notification_service_controller.dart';
import 'package:app_qldt/_services/controller/score_service_controller.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/database/table/data_version.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';
import 'package:app_qldt/_models/user_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preload_event.dart';

part 'preload_state.dart';

class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  final BuildContext context;
  final NavigatorState? navigator;
  final String _idAccount;
  final String _idUser;

  PreloadBloc({
    required this.context,
    required this.navigator,
    required User user,
  })  : _idAccount = user.accountId,
        _idUser = user.id,
        super(PreloadInitial());

  @override
  Stream<PreloadState> mapEventToState(
    PreloadEvent event,
  ) async* {
    if (event is PreloadStatusChanged) {
      yield* _mapPreloadStatusChangedToState(event);
    } else if (event is PreloadLoading) {
      yield* _mapPreloadLoadingToState(event);
    } else if (event is PreloadLoadingAfterLogin) {
      yield* _mapPreloadLoadingAfterLoginToState(event);
    }
  }

  Stream<PreloadState> _mapPreloadStatusChangedToState(PreloadStatusChanged event) async* {
    yield state.copyWith(status: event.status);
  }

  Stream<PreloadState> _mapPreloadLoadingToState(PreloadLoading event) async* {
    yield PreloadState.loading();

    Stopwatch stopwatch = Stopwatch()..start();
    final minTurnAroundTime = const Duration(seconds: 2);
    final ApiUrl apiUrl = AppModeWidget.of(context).apiUrl;
    final serviceControllers = _ServiceControllers(
      apiUrl: apiUrl,
      idUser: _idUser,
      idAccount: _idAccount,
    );

    await Future.wait([
      upsertToken(apiUrl),
      initControllersAndRefreshNewVersion(serviceControllers, apiUrl),
    ]);

    final timeEnded = stopwatch.elapsed;
    stopwatch.stop();

    print(timeEnded);

    final userDataModel = UserDataModel(
      eventServiceController: serviceControllers.event,
      scoreServiceController: serviceControllers.score,
      notificationServiceController: serviceControllers.notification,
      examScheduleServiceController: serviceControllers.examSchedule,
      idAccount: _idAccount,
      idUser: _idUser,
    );

    context.read<UserRepository>().userDataModel = userDataModel;

    await Future.delayed(
        timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0), () async {
      await navigator?.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });

    yield PreloadState.loaded(userDataModel);
  }

  Stream<PreloadState> _mapPreloadLoadingAfterLoginToState(PreloadLoadingAfterLogin event) async* {
    yield PreloadState.loadingAfterLogin();

    Stopwatch stopwatch = Stopwatch()..start();
    final minTurnAroundTime = const Duration(seconds: 2);
    final ApiUrl apiUrl = AppModeWidget.of(context).apiUrl;
    final serviceControllers = _ServiceControllers(
      apiUrl: apiUrl,
      idUser: _idUser,
      idAccount: _idAccount,
    );

    await Future.wait([
      upsertToken(apiUrl),
      initControllersAndForceRefresh(serviceControllers),
    ]);

    final timeEnded = stopwatch.elapsed;
    stopwatch.stop();

    print(timeEnded);

    final userDataModel = UserDataModel(
      eventServiceController: serviceControllers.event,
      scoreServiceController: serviceControllers.score,
      notificationServiceController: serviceControllers.notification,
      examScheduleServiceController: serviceControllers.examSchedule,
      idAccount: _idAccount,
      idUser: _idUser,
    );

    context.read<UserRepository>().userDataModel = userDataModel;

    await Future.delayed(
        timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0), () async {
      await navigator?.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });

    yield PreloadState.loaded(userDataModel);
  }

  Future<void> upsertToken(ApiUrl apiUrl) async {
    final tokenService = TokenService(apiUrl);
    await tokenService.init();
    await tokenService.upsert(_idUser);
  }

  Future<void> initControllersAndRefreshNewVersion(
      _ServiceControllers serviceControllers, ApiUrl apiUrl) async {
    await serviceControllers.init(loadOldData: true);

    Map<String, dynamic> versionMap = await VersionService(
      apiUrl: apiUrl,
      idStudent: _idUser,
    ).getServerDataVersion();

    if (versionMap.isNotEmpty) {
      print(versionMap);
      await serviceControllers.refresh(versionMap);
    }
  }

  Future<void> initControllersAndForceRefresh(_ServiceControllers serviceControllers) async {
    await serviceControllers.init();
    await serviceControllers.forceRefresh();
  }
}

class _ServiceControllers {
  late final EventServiceController event;
  late final ScoreServiceController score;
  late final NotificationServiceController notification;
  late final ExamScheduleServiceController examSchedule;
  final ApiUrl apiUrl;
  final String idUser;
  final String idAccount;

  _ServiceControllers({
    required this.apiUrl,
    required this.idAccount,
    required this.idUser,
  });

  Future<void> init({bool loadOldData = false}) async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    final ServiceControllerData controllerData = ServiceControllerData(
      databaseProvider: databaseProvider,
      apiUrl: apiUrl,
      idUser: idUser,
    );

    event = EventServiceController(controllerData);
    score = ScoreServiceController(controllerData);
    notification = NotificationServiceController(controllerData, idAccount);
    examSchedule = ExamScheduleServiceController(controllerData);

    if (loadOldData) {
      await Future.wait([
        event.load(),
        notification.load(),
        score.load(),
        examSchedule.load(),
      ]);
    }
  }

  Future<void> refresh(Map<String, dynamic> versionMap) async {
    DbDataVersion version = event.localService.databaseProvider.dataVersion;

    await Future.wait([
      _refreshEvent(versionMap['Schedule']! as int, version.schedule),
      _refreshNotification(versionMap['Notification']! as int, version.notification),
      _refreshExamSchedule(versionMap['Exam_Schedule']! as int, version.examSchedule),
      _refreshScore(versionMap['Module_Score']! as int, version.score),
    ]);
  }

  Future<void> forceRefresh() async {
    await Future.wait([
      _forceRefreshEvent(),
      _forceRefreshNotification(getAll: true),
      _forceRefreshExamSchedule(),
      _forceRefreshScore(),
    ]);
  }

  Future<void> _refreshEvent(int serverVersion, localVersion) async {
    if (serverVersion > localVersion) {
      await _forceRefreshEvent();
    }
  }

  Future<void> _forceRefreshEvent() async {
    await event.refresh();
  }

  Future<void> _refreshNotification(int serverVersion, localVersion) async {
    if (serverVersion > localVersion) {
      await _forceRefreshNotification();
    } else if (localVersion > 0) {
      examSchedule.setConnected();
    }
  }

  Future<void> _forceRefreshNotification({bool getAll = false}) async {
    await notification.refresh(getAll: getAll);
  }

  Future<void> _refreshExamSchedule(int serverVersion, localVersion) async {
    if (serverVersion > localVersion) {
      await _forceRefreshExamSchedule();
    }
  }

  Future<void> _forceRefreshExamSchedule() async {
    await examSchedule.refresh();
  }

  Future<void> _refreshScore(int serverVersion, localVersion) async {
    if (serverVersion > localVersion) {
      await _forceRefreshScore();
    } else if (localVersion > 0) {
      score.setConnected();
    }
  }

  Future<void> _forceRefreshScore() async {
    await score.refresh();
  }
}
