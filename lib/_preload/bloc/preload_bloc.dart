import 'dart:async';

import 'package:app_qldt/_models/service_controller_data.dart';
import 'package:app_qldt/_repositories/user_repository/src/models/user.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_services/api/token_service.dart';
import 'package:app_qldt/_services/controller/event_service_controller.dart';
import 'package:app_qldt/_services/controller/exam_schedule_service_controller.dart';
import 'package:app_qldt/_services/controller/notification_service_controller.dart';
import 'package:app_qldt/_services/controller/score_service_controller.dart';
import 'package:app_qldt/_utils/database/provider.dart';
import 'package:app_qldt/_utils/helper/const.dart';
import 'package:app_qldt/_widgets/model/app_mode.dart';
import 'package:app_qldt/_models/user_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_qldt/_utils/secret/url/url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }) : super(PreloadInitial());

  @override
  Stream<PreloadState> mapEventToState(
    PreloadEvent event,
  ) async* {
    if (event is PreloadStatusChanged) {
      yield* _mapPreloadStatusChangedToState(event);
    } else if (event is PreloadLoading) {
      yield* _mapPreloadLoadingToState(event);
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

    /// Khởi động các service
    final tokenService = TokenService(apiUrl);
    await tokenService.init();
    await tokenService.upsert(user.id);

    String idAccount = user.accountId;
    String idUser = user.id;

    final DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    final ServiceControllerData controllerData = ServiceControllerData(
      databaseProvider: databaseProvider,
      apiUrl: apiUrl,
      idUser: idUser,
    );

    EventServiceController eventServiceController = EventServiceController(controllerData);
    ScoreServiceController scoreServiceController = ScoreServiceController(controllerData);
    NotificationServiceController notificationServiceController =
        NotificationServiceController(controllerData, idAccount);
    ExamScheduleServiceController examScheduleServiceController =
        ExamScheduleServiceController(controllerData);

    print('Event: ${stopwatch.elapsed}');
    await eventServiceController.refresh();

    print('Score: ${stopwatch.elapsed}');
    await scoreServiceController.refresh();

    print('Notification: ${stopwatch.elapsed}');
    await notificationServiceController.refresh();

    print('Exam Schedule: ${stopwatch.elapsed}');
    await examScheduleServiceController.refresh();

    final timeEnded = stopwatch.elapsed;
    stopwatch.stop();

    print(timeEnded);

    context.read<UserRepository>().userDataModel = UserDataModel(
      eventServiceController: eventServiceController,
      scoreServiceController: scoreServiceController,
      notificationServiceController: notificationServiceController,
      examScheduleServiceController: examScheduleServiceController,
      idAccount: idAccount,
      idStudent: idUser,
    );

    await Future.delayed(
        timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0),
        () async {
      await navigator?.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });

    yield PreloadState.loaded(
      eventServiceController: eventServiceController,
      scoreServiceController: scoreServiceController,
      notificationServiceController: notificationServiceController,
      examScheduleServiceController: examScheduleServiceController,
      idAccount: idAccount,
      idUser: idUser,
    );
  }
}
