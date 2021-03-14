import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_models/screen.dart';
import 'package:app_qldt/_services/local_notification_service.dart';
import 'package:app_qldt/_services/local_event_service.dart';
import 'package:app_qldt/_widgets/user_data_model.dart';

import 'package:app_qldt/calendar/calendar.dart';
import 'package:app_qldt/notification/notification.dart';
import 'package:app_qldt/sidebar/sidebar.dart';

class App extends StatelessWidget {
  static Route route({
    required LocalNotificationService localNotificationService,
    required LocalEventService localScheduleService,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => UserDataModel(
        localNotificationService: localNotificationService,
        localEventService: localScheduleService,
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
          builder: (_, state) {
            return _getScreen(state.screenPage);
          },
        ),
      ),
    );
  }

  Widget _getScreen(ScreenPage screenPage) {
    switch (screenPage) {
      case ScreenPage.home:
        return CalendarPage();

      case ScreenPage.notification:
        return NotificationPage();

      default:
        return Container();
    }
  }
}
