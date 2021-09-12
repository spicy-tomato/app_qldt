import 'package:app_qldt/blocs/app_setting/app_setting_bloc.dart';
import 'package:app_qldt/config/config.dart';
import 'package:app_qldt/constant/constant.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/preload/preload_bloc.dart';
import 'repositories/authentication_repository/authentication_repository.dart';
import 'repositories/user_repository/user_repository.dart';
import 'screens/main/calendar/calendar_page.dart';
import 'screens/main/exam_schedule/exam_schedule_page.dart';
import 'screens/main/home/home_page.dart';
import 'screens/main/login/login_page.dart';
import 'screens/main/notification/notification_page.dart';
import 'screens/main/schedule/schedule_page.dart';
import 'screens/main/score/score_page.dart';
import 'screens/main/setting/setting.dart';
import 'screens/main/splash/splash_page.dart';

class Application extends StatefulWidget {
  final _authenticationRepository = AuthenticationRepository();
  final _userRepository = UserRepository();

  Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  NavigatorState? get _navigator => _navigatorKey.currentState;
  bool _shouldLoadAfterLogin = false;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget._authenticationRepository),
        RepositoryProvider.value(value: widget._userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: widget._authenticationRepository,
              userRepository: widget._userRepository,
            ),
          ),
          BlocProvider(create: (_) => AppSettingBloc())
        ],
        child: BlocBuilder<AppSettingBloc, AppSettingState>(
          builder: (_, state) {
            return MaterialApp(
              theme: ThemeData(
                fontFamily: AppConstant.fontFamily,
                // primaryColor: state.theme.data.primaryColor,
                // accentColor: state.theme.data.secondaryColor,
                // colorScheme: ColorScheme.light(
                //   primary: state.theme.data.primaryColor,
                //   onPrimary: state.theme.data.primaryTextColor,
                //   onSurface: state.theme.data.secondaryTextColor,
                // ),
                // textButtonTheme: TextButtonThemeData(
                //   style: TextButton.styleFrom(
                //     primary: state.theme.data.secondaryTextColor,
                //   )
                // ),
              ),
              localizationsDelegates: AppConfig.localizationsDelegates,
              supportedLocales: AppConfig.supportedLocales,
              locale: state.locale.data,
              navigatorKey: _navigatorKey,
              builder: (context, child) {
                return SafeArea(
                  child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) async {
                      switch (state.status) {
                        case AuthenticationStatus.unauthenticated:
                          _shouldLoadAfterLogin = true;
                          await unauthenticated();
                          break;

                        case AuthenticationStatus.authenticated:
                          await authenticated(state);
                          break;

                        default:
                          _shouldLoadAfterLogin = false;
                          await defaultCase();
                          break;
                      }
                    },
                    buildWhen: (previous, current) => previous.status != current.status,
                    builder: (context, state) {
                      if (!state.status.isAuthenticated) {
                        return child!;
                      }

                      return BlocProvider<PreloadBloc>(
                        create: (_) => PreloadBloc(
                          context: context,
                          user: state.user,
                          navigator: _navigator,
                        )..add(_shouldLoadAfterLogin ? PreloadLoadingAfterLogin() : PreloadLoading()),
                        child: BlocBuilder<PreloadBloc, PreloadState>(
                          buildWhen: (previous, current) => previous.status != current.status,
                          builder: (context, state) {
                            return child!;
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              routes: {
                '/': (_) => SplashPage(_shouldLoadAfterLogin),
                '/login': (_) => const LoginPage(),
                '/home': (_) => const HomePage(),
                '/calendar': (_) => CalendarPage(),
                '/schedule': (_) => const SchedulePage(),
                '/score': (_) => ScorePage(),
                '/examSchedule': (_) => ExamSchedulePage(),
                '/notification': (_) => const NotificationPage(),
                '/setting': (_) => const SettingPage(),
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> unauthenticated() async {
    if (ModalRoute.of(context)?.settings.name != '/login') {
      await _navigator!.pushNamedAndRemoveUntil('/login', (_) => false);
    }
  }

  Future<void> authenticated(AuthenticationState state) async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      await _navigator!.pushNamedAndRemoveUntil('/', (_) => false);
    }
  }

  Future<void> defaultCase() async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      await _navigator!.pushNamedAndRemoveUntil('/', (_) => false);
      await Future.delayed(const Duration(milliseconds: 2000));
    }
  }
}
