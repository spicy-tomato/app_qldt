import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '_authentication/authentication.dart';

import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';

import '_services/local_notification_service.dart';
import '_services/local_schedule_service.dart';
import '_services/token_service.dart';

import 'app_view/app_view.dart';
import 'app_view/transition_route_observer.dart';
import 'login/login.dart';
import 'splash/splash.dart';

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
      theme: ThemeData(
        //  Brightness and colors
        brightness: Brightness.light,
        primaryColor: Color(0xff4A2A73),
        accentColor: Color(0xffF46781),
        backgroundColor: Color(0xff4A2A73),

        //  Font family
        fontFamily: 'Montserrat',

        //  Text theme
        textTheme: TextTheme(
          //  https://api.flutter.dev/flutter/material/TextTheme-class.html
          //  Headline
          headline5: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          headline6: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),

          //  Body text
          bodyText1: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
          bodyText2: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
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

              /// Khi chưa đăng nhập
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  SplashPage.route(),
                  (route) => false,
                );

                Future.delayed(const Duration(seconds: 0), () {
                  _navigator!.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                });
                break;

              /// Khi đã đăng nhập
              case AuthenticationStatus.authenticated:

                /// Khởi động các service
                final tokenService = TokenService();
                tokenService.init();
                tokenService.upsert(state.user.id);

                final localNotificationService = LocalNotificationService(state.user.id);
                final localScheduleService = LocalScheduleService(state.user.id);

                await localNotificationService.refresh();
                await localScheduleService.refresh();

                /// Vào route
                _navigator!.pushAndRemoveUntil<void>(
                  App.route(
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
