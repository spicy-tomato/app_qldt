import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/authentication/authentication.dart';
import 'package:app_qldt/calendar/calendar.dart';
import 'package:app_qldt/models/screen.dart';
import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';
import 'package:app_qldt/utils/const.dart';

class App extends StatelessWidget {
  final Map<DateTime, List<dynamic>> schedulesData;

  static Route route(Map<DateTime, List<dynamic>> schedulesData) {
    return MaterialPageRoute<void>(
      builder: (_) => App(schedulesData: schedulesData),
    );
  }

  App({Key? key, required this.schedulesData}) : super(key: key);

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
                        top: MediaQuery.of(context).size.height *
                            Const.contentTopPaddingRatio,
                        left: MediaQuery.of(context).size.width *
                            Const.contentLeftPaddingRatio,
                        right: MediaQuery.of(context).size.width *
                            Const.contentRightPaddingRatio,
                      ),
                      child: _getScreen(state.screenPage, schedulesData),
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

  static Widget _getScreen(
    ScreenPage screenPage,
    Map<DateTime, List<dynamic>> schedulesData,
  ) {
    switch (screenPage) {
      case ScreenPage.home:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CalendarPage(schedulesData: schedulesData);
          },
        );

      default:
        return Container();
    }
  }
}
