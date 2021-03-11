import 'package:app_qldt/_services/local_notification_service.dart';
import 'package:app_qldt/_services/local_schedule_service.dart';
import 'package:app_qldt/notification/notification.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_authentication/authentication.dart';
import 'package:app_qldt/calendar/calendar.dart';
import 'package:app_qldt/_models/screen.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';
import 'package:app_qldt/_utils/const.dart';
import 'package:collection/collection.dart';

enum ServiceEnum {
  notification,
  schedule,
}

class UserDataModel extends InheritedModel<ServiceEnum> {
  final LocalNotificationService localNotificationService;
  final LocalScheduleService localScheduleService;

  UserDataModel({
    required this.localNotificationService,
    required this.localScheduleService,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(UserDataModel old) {
    return !DeepCollectionEquality().equals(
          localScheduleService.schedulesData,
          old.localScheduleService.schedulesData,
        ) ||
        !DeepCollectionEquality().equals(
          localNotificationService.notificationData,
          old.localNotificationService.notificationData,
        );
  }

  @override
  bool updateShouldNotifyDependent(UserDataModel old, Set<ServiceEnum> aspect) {
    return (aspect.contains(ServiceEnum.notification) &&
            !DeepCollectionEquality().equals(
              localNotificationService.notificationData,
              old.localNotificationService.notificationData,
            )) ||
        (aspect.contains(ServiceEnum.notification) &&
            !DeepCollectionEquality().equals(
              localScheduleService.schedulesData,
              old.localScheduleService.schedulesData,
            ));
  }

  static UserDataModel? of(BuildContext context, {ServiceEnum? aspect}) {
    return InheritedModel.inheritFrom<UserDataModel>(context, aspect: aspect);
  }
}

class App extends StatelessWidget {
  static Route route({
    required String studentId,
    required LocalNotificationService localNotificationService,
    required LocalScheduleService localScheduleService,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => UserDataModel(
        localNotificationService: localNotificationService,
        localScheduleService: localScheduleService,
        child: App(),
      ),
    );
  }

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return ScreenBloc();
        },
        child: BlocBuilder<ScreenBloc, ScreenState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Const.interfaceBackgroundColor,
              drawer: Sidebar(),
              body: Container(
                child: Stack(
                  children: <Widget>[
                    TopBar(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * Const.contentTopPaddingRatio,
                        left: MediaQuery.of(context).size.width * Const.contentLeftPaddingRatio,
                        right: MediaQuery.of(context).size.width * Const.contentRightPaddingRatio,
                      ),
                      child: _getScreen(state.screenPage),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getScreen(ScreenPage screenPage) {
    switch (screenPage) {
      case ScreenPage.home:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CalendarPage();
          },
        );

      case ScreenPage.notification:
        return NotificationPage();

      default:
        return Container();
    }
  }
}
