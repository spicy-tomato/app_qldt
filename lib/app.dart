import 'package:app_qldt/_utils/helper/pull_to_fresh_vn_delegate.dart';
import 'package:app_qldt/exam_schedule/exam_schedule.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '_authentication/authentication.dart';
import '_preload/preload.dart';
import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';
import '_utils/helper/sf_localization_vn_delegate.dart';
import '_widgets/splash/splash.dart';

import 'calendar/calendar.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'notification/notification.dart';
import 'schedule/schedule.dart';
import 'score/score.dart';

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

  final _themeData = ThemeData(
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
  );

  final _localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    SfLocalizationsVnDelegate(),
    PullToRefreshVnDelegate(),
  ];

  final _supportedLocales = [const Locale('vi', '')];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget._authenticationRepository),
        RepositoryProvider.value(value: widget._userRepository),
      ],
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: widget._authenticationRepository,
          userRepository: widget._userRepository,
        ),
        child: MaterialApp(
          theme: _themeData,
          navigatorKey: _navigatorKey,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _supportedLocales,
          locale: const Locale('vi', ''),
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
            '/login': (_) => LoginPage(),
            '/home': (_) => HomePage(),
            '/calendar': (_) => CalendarPage(),
            '/schedule': (_) => SchedulePage(),
            '/score': (_) => ScorePage(),
            '/examSchedule': (_) => ExamSchedulePage(),
            '/notification': (_) => NotificationPage(),
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
