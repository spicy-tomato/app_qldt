import 'package:app_qldt/authentication/authentication.dart';
import 'package:app_qldt/screen/screen.dart';
import 'package:app_qldt/screens/home/local_widgets/calendar.dart';
import 'package:sidebar_repository/sidebar_repository.dart';
import 'package:tab_repository/tab_repository.dart';

import 'package:app_qldt/sidebar/sidebar.dart';
import 'package:app_qldt/topbar/topbar.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_repository/firebase_repository.dart';

class App extends StatelessWidget {
  // final _navigatorKey = new GlobalKey<NavigatorState>();
  final ScreenRepository screenRepository;

  static Route route(ScreenRepository screenRepository) {
    return MaterialPageRoute<void>(
      builder: (_) => App(screenRepository: screenRepository),
    );
  }

  const App({
    Key key,
    @required this.screenRepository,
  })  : assert(screenRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SidebarBloc(
          sidebarRepository: SidebarRepository(),
          tabRepository: screenRepository,
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Const.interfaceBackgroundColor,
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
                        buildWhen: (previous, current) =>
                            previous.screenPage != current.screenPage,
                        builder: (context, state) =>
                            getScreen(state.screenPage),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          drawer: Sidebar(),
        ),
      ),
    );
  }

  static Widget getScreen(ScreenPage screenPage) {
    switch (screenPage) {
      case ScreenPage.Home:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Calendar(
              studentId: state.user.id,
              firebaseRepository: FirebaseRepository(),
            );
          },
        );

      default:
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Calendar(
              studentId: state.user.id,
              firebaseRepository: FirebaseRepository(),
            );
          },
        );
    }
  }
}
