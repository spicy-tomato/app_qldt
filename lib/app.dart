import 'dart:math';

import 'package:app_qldt/_services/local_notification_service.dart';
import 'package:app_qldt/_services/local_schedule_service.dart';
import 'package:app_qldt/_services/token_service.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:app_qldt/_repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';

import 'package:app_qldt/_authentication/authentication.dart';
import 'package:app_qldt/app/app.dart';
import 'package:app_qldt/login/login.dart';
import 'package:app_qldt/splash/splash.dart';
import 'app/transition_route_observer.dart';

class Application extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const Application({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }

  static int getRandomTime() {
    final rng = new Random();
    int minTime = 2550;
    int maxTime = 5000;
    return rng.nextInt(maxTime - minTime) + minTime;
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', ''),
      ],
      navigatorObservers: [TransitionRouteObserver()],
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            switch (state.status) {
              case AuthenticationStatus.unauthenticated:
                //  Display splash page in 2 seconds, then display login page
                _navigator!.pushAndRemoveUntil<void>(
                  SplashPage.route(),
                  (route) => false,
                );

                Future.delayed(const Duration(seconds: 2), () {
                  _navigator!.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                });
                break;

              case AuthenticationStatus.authenticated:
                final tokenService = TokenService();
                tokenService.init();
                tokenService.upsert(state.user.id);

                final localNotificationService = LocalNotificationService(state.user.id);
                final localScheduleService = LocalScheduleService(state.user.id);

                await localNotificationService.refresh();
                await localScheduleService.refresh();

                _navigator!.pushAndRemoveUntil<void>(
                  App.route(
                    studentId: state.user.id,
                    localScheduleService: localScheduleService,
                    localNotificationService: localNotificationService,
                  ),
                  (route) => false,
                );
                break;

              default:
                _navigator!.pushAndRemoveUntil<void>(
                  SplashPage.route(),
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return SplashPage.route();
      },
    );
  }
}
