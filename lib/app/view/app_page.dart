import 'package:app_qldt/authentication/authentication.dart';
import 'package:app_qldt/calendar/calendar.dart';
import 'package:app_qldt/screen/screen.dart';
import 'package:sidebar_repository/sidebar_repository.dart';
import 'package:tab_repository/screen_repository.dart';

import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_repository/firebase_repository.dart';

class App extends StatelessWidget {
  final ScreenRepository screenRepository;
  final FirebaseRepository firebaseRepository;

  static Route route(
    ScreenRepository screenRepository,
    FirebaseRepository firebaseRepository,
  ) {
    return MaterialPageRoute<void>(
      builder: (_) => App(
        screenRepository: screenRepository,
        firebaseRepository: firebaseRepository,
      ),
    );
  }

  App({
    Key key,
    @required this.screenRepository,
    @required this.firebaseRepository,
  })  : assert(screenRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return SidebarBloc(
            sidebarRepository: SidebarRepository(),
            screenRepository: screenRepository,
          );
        },
        child: Scaffold(
          backgroundColor: Const.interfaceBackgroundColor,
          drawer: Sidebar(),
          body: BlocListener<SidebarBloc, SidebarState>(
            listener: (context, state) {
              if (state.status.shouldOpen) {
                Scaffold.of(context)..openDrawer();
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              child: Stack(
                children: [
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
                      create: (context) => ScreenBloc(
                        screenRepository: screenRepository,
                      ),
                      child: BlocBuilder<ScreenBloc, ScreenState>(
                        builder: (context, state) =>
                            getScreen(state.screenPage),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget getScreen(ScreenPage screenPage) {
    // print('Screen page: $screenPage');

    switch (screenPage) {
      case ScreenPage.home:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CalendarPage(
              studentId: state.user.id,
              firebaseRepository: FirebaseRepository(),
            );
          },
        );

      default:
        return Container();
    }
  }
}
