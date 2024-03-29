import 'dart:async';

import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/database/table/data_version.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:app_qldt/models/service/service_controller_data.dart';
import 'package:app_qldt/models/service/user_data_model.dart';
import 'package:app_qldt/repositories/user_repository/src/models/user.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';
import 'package:app_qldt/services/api/token_service.dart';
import 'package:app_qldt/services/api/version_service.dart';
import 'package:app_qldt/services/controller/event_service_controller.dart';
import 'package:app_qldt/services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/services/controller/notification_service_controller.dart';
import 'package:app_qldt/services/controller/score_service_controller.dart';
import 'package:app_qldt/widgets/wrapper/app_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preload_event.dart';

part 'preload_state.dart';

class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  final BuildContext context;
  final NavigatorState? navigator;
  final User user;

  PreloadBloc({
    required this.context,
    required this.navigator,
    required this.user,
  }) : super(const PreloadInitial());

  @override
  Stream<PreloadState> mapEventToState(
    PreloadEvent event,
  ) async* {
    if (event is PreloadStatusChanged) {
      yield* _mapPreloadStatusChangedToState(event);
    } else if (event is PreloadLoading) {
      yield* _mapPreloadLoadingToState();
    } else if (event is PreloadLoadingAfterLogin) {
      yield* _mapPreloadLoadingAfterLoginToState();
    }
  }

  Stream<PreloadState> _mapPreloadStatusChangedToState(PreloadStatusChanged event) async* {
    yield state.copyWith(status: event.status);
  }

  Stream<PreloadState> _mapPreloadLoadingToState() async* {
    yield const PreloadState.loading();
    String? avatarPath;

    final Stopwatch stopwatch = Stopwatch()..start();
    const minTurnAroundTime = Duration(seconds: 2);
    final ApiUrl apiUrl = AppModeWidget.of(context).apiUrl;
    final serviceControllers = _ServiceControllers(apiUrl: apiUrl, user: user);

    await Future.wait([
      _upsertToken(apiUrl),
      _initAndRefreshApiServices(serviceControllers, apiUrl),
      (() async => avatarPath = await _loadAvatarPath())(),
    ]);

    final timeEnded = stopwatch.elapsed;
    stopwatch.stop();

    debugPrint(timeEnded.toString());

    final userDataModel = UserDataModel(
      eventServiceController: serviceControllers.event,
      scoreServiceController: serviceControllers.score,
      notificationServiceController: serviceControllers.notification,
      examScheduleServiceController: serviceControllers.examSchedule,
      uuidAccount: user.uuidAccount,
      idUser: user.id,
      role: user.role,
      avatarPath: avatarPath ?? '',
    );

    context.read<UserRepository>().userDataModel = userDataModel;

    await Future.delayed(timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0), () async {
      await navigator?.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });

    yield PreloadState.loaded(userDataModel);
  }

  Stream<PreloadState> _mapPreloadLoadingAfterLoginToState() async* {
    yield const PreloadState.loadingAfterLogin();
    String? avatarPath;

    final Stopwatch stopwatch = Stopwatch()..start();
    const minTurnAroundTime = Duration(seconds: 2);
    final ApiUrl apiUrl = AppModeWidget.of(context).apiUrl;
    final serviceControllers = _ServiceControllers(apiUrl: apiUrl, user: user);

    await Future.wait([
      _upsertToken(apiUrl),
      _initAndRefreshApiServices(serviceControllers, apiUrl, force: true),
      (() async => avatarPath = await _loadAvatarPath())(),
    ]);

    final timeEnded = stopwatch.elapsed;
    stopwatch.stop();

    debugPrint(timeEnded.toString());

    final userDataModel = UserDataModel(
      eventServiceController: serviceControllers.event,
      scoreServiceController: serviceControllers.score,
      notificationServiceController: serviceControllers.notification,
      examScheduleServiceController: serviceControllers.examSchedule,
      uuidAccount: user.uuidAccount,
      idUser: user.id,
      role: user.role,
      avatarPath: avatarPath ?? '',
    );

    context.read<UserRepository>().userDataModel = userDataModel;

    await Future.delayed(timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0), () async {
      await navigator?.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });

    yield PreloadState.loaded(userDataModel);
  }

  Future<void> _upsertToken(ApiUrl apiUrl) async {
    final tokenService = TokenService(apiUrl);
    await tokenService.init();
    await tokenService.upsert(user.id);
  }

  Future<void> _initAndRefreshApiServices(
    _ServiceControllers serviceControllers,
    ApiUrl apiUrl, {
    bool force = false,
  }) async {
    await serviceControllers.init(loadOldData: !force);

    final Map<String, dynamic> versionMap = await VersionService(
      apiUrl: apiUrl,
      idStudent: user.id,
    ).getServerDataVersion();

    if (versionMap.isNotEmpty) {
      debugPrint(versionMap.toString());
      if (force) {
        await serviceControllers.forceRefresh(versionMap);
      } else {
        await serviceControllers.refresh(versionMap);
      }
    }
  }

  Future<String?> _loadAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatar_path');
  }
}

class _ServiceControllers {
  late final EventServiceController event;
  late final ScoreServiceController score;
  late final NotificationServiceController notification;
  late final ExamScheduleServiceController examSchedule;
  final ApiUrl apiUrl;
  final User user;

  _ServiceControllers({required this.apiUrl, required this.user});

  Future<void> init({bool loadOldData = false}) async {
    final DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    final ServiceControllerData controllerData = ServiceControllerData(
      databaseProvider: databaseProvider,
      apiUrl: apiUrl,
      user: user,
    );

    event = EventServiceController(controllerData);
    score = ScoreServiceController(controllerData);
    notification = NotificationServiceController(controllerData, user.uuidAccount);
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
    final DbDataVersion version = event.localService.databaseProvider.dataVersion;

    await Future.wait([
      _refreshEvent(versionMap['Schedule'] as int?, version.schedule),
      _refreshNotification(versionMap['Notification'] as int?, version.notification),
      _refreshExamSchedule(versionMap['Exam_Schedule'] as int?, version.examSchedule),
      _refreshScore(versionMap['Module_Score'] as int?, version.score),
    ]);
  }

  Future<void> forceRefresh(Map<String, dynamic> versionMap) async {
    await Future.wait([
      _forceRefreshEvent(),
      _forceRefreshNotification(getAll: true),
      _forceRefreshExamSchedule(versionMap['Exam_Schedule'] as int?),
      _forceRefreshScore(versionMap['Module_Score'] as int?),
    ]);
  }

  Future<void> _refreshEvent(int? serverVersion, localVersion) async {
    if (serverVersion != null) {
      if (serverVersion > localVersion) {
        await _forceRefreshEvent();
      }
    }
  }

  Future<void> _forceRefreshEvent() async {
    await event.refresh();
  }

  Future<void> _refreshNotification(int? serverVersion, localVersion) async {
    if (serverVersion != null) {
      if (serverVersion > localVersion) {
        await _forceRefreshNotification();
      }
    }
  }

  Future<void> _forceRefreshNotification({bool getAll = false}) async {
    await notification.refresh(getAll: getAll);
  }

  Future<void> _refreshExamSchedule(int? serverVersion, localVersion) async {
    if (serverVersion != null) {
      if (serverVersion > localVersion) {
        await _forceRefreshExamSchedule(serverVersion);
      } else if (localVersion > 0) {
        examSchedule.setConnected();
      }
    }
  }

  Future<void> _forceRefreshExamSchedule([int? newVersion]) async {
    await examSchedule.refresh(newVersion);
  }

  Future<void> _refreshScore(int? serverVersion, localVersion) async {
    if (serverVersion != null) {
      if (serverVersion > localVersion) {
        await _forceRefreshScore(serverVersion);
      } else if (localVersion > 0) {
        score.setConnected();
      }
    }
  }

  Future<void> _forceRefreshScore([int? newVersion]) async {
    await score.refresh(newVersion);
  }
}
