import 'package:app_qldt/authentication/authentication.dart';
import 'package:app_qldt/calendar/calendar.dart';
import 'package:app_qldt/models/screen.dart';
import 'package:app_qldt/screen/screen.dart';

import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => App(),
    );
  }

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return SidebarBloc();
        },
        child: BlocBuilder<SidebarBloc, SidebarState>(
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
                      child: BlocProvider(
                        create: (context) => ScreenBloc(),
                        child: BlocBuilder<ScreenBloc, ScreenState>(
                          buildWhen: (previous, current) {
                            // print(previous.screenPage);
                            // print(current.screenPage);
                            // print('---------');
                            return previous.screenPage != current.screenPage;
                          },
                          builder: (context, state) =>
                              getScreen(state.screenPage),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget getScreen(ScreenPage screenPage) {
    switch (screenPage) {
      case ScreenPage.home:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CalendarPage(studentId: state.user.id);
          },
        );

      default:
        return Container();
    }
  }
}
