import 'package:app_qldt/_services/local/local_exam_schedule_service.dart';
import 'package:app_qldt/_services/local/local_score_service.dart';
import 'package:app_qldt/_utils/helper/pull_to_fresh_vn_delegate.dart';
import 'package:app_qldt/exam_schedule/exam_schedule.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '_authentication/authentication.dart';
import '_repositories/authentication_repository/authentication_repository.dart';
import '_repositories/user_repository/user_repository.dart';
import '_services/local/local_event_service.dart';
import '_services/local/local_notification_service.dart';
import '_services/web/token_service.dart';
import '_utils/database/provider.dart';
import '_utils/helper/sf_localization_vn_delegate.dart';
import '_utils/helper/const.dart';
import '_widgets/splash/splash.dart';
import '_widgets/model/user_data_model.dart';

import 'calendar/calendar.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'notification/notification.dart';
import 'schedule/schedule.dart';
import 'score/score.dart';

class Application extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const Application({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  LocalEventService? _localEventService;
  LocalScoreService? _localScoreService;
  LocalNotificationService? _localNotificationService;
  LocalExamScheduleService? _localExamScheduleService;

  NavigatorState? get _navigator => _navigatorKey.currentState;

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
    return RepositoryProvider.value(
      value: widget.authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: widget.authenticationRepository,
          userRepository: widget.userRepository,
        ),
        child: MaterialApp(
          theme: _themeData,
          navigatorKey: _navigatorKey,
          localizationsDelegates: _localizationsDelegates,
          supportedLocales: _supportedLocales,
          locale: const Locale('vi', ''),
          builder: (context, child) {
            return SafeArea(
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) async {
                  switch (state.status) {
                    case AuthenticationStatus.unauthenticated:
                      unauthenticated();
                      break;

                    case AuthenticationStatus.authenticated:
                      authenticated(state);
                      break;

                    default:
                      defaultCase();
                      break;
                  }
                },
                child: child,
              ),
            );
          },
          routes: {
            '/': (_) => SplashPage(),
            '/login': (_) => LoginPage(),
            '/home': (_) => userData(HomePage()),
            '/calendar': (_) => userData(CalendarPage()),
            '/schedule': (_) => userData(SchedulePage()),
            '/score': (_) => userData(ScorePage()),
            '/examSchedule': (_) => userData(ExamSchedulePage()),
            '/notification': (_) => userData(NotificationPage()),
          },
        ),
      ),
    );
  }

  Widget userData(Widget child) {
    return UserDataModel(
      localEventService: _localEventService!,
      localScoreService: _localScoreService!,
      localNotificationService: _localNotificationService!,
      localExamScheduleService: _localExamScheduleService!,
      child: child,
    );
  }

  void unauthenticated() async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      _navigator!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    _localEventService = null;
    _localScoreService = null;
    _localNotificationService = null;
    _localExamScheduleService = null;

    await Future.delayed(const Duration(milliseconds: 1500), () {
      _navigator!.pushNamedAndRemoveUntil('/login', (_) => false);
    });
  }

  void authenticated(AuthenticationState state) async {
    if (ModalRoute.of(context)?.settings.name != '/') {
      _navigator!.pushNamedAndRemoveUntil('/', (_) => false);
    }

    Stopwatch stopwatch = Stopwatch()..start();
    final minTurnAroundTime = const Duration(milliseconds: 1000);

    /// Khởi động các service
    final tokenService = TokenService();
    await tokenService.init();
    await tokenService.upsert(state.user.id);

    DatabaseProvider databaseProvider = DatabaseProvider();
    await databaseProvider.init();

    _localEventService =
        LocalEventService(databaseProvider: databaseProvider, userId: state.user.id);
    _localScoreService =
        LocalScoreService(databaseProvider: databaseProvider, userId: state.user.id);
    _localNotificationService =
        LocalNotificationService(databaseProvider: databaseProvider, userId: state.user.id);
    _localExamScheduleService =
        LocalExamScheduleService(databaseProvider: databaseProvider, userId: state.user.id);

    await _localEventService!.refresh();
    await _localScoreService!.refresh();
    await _localNotificationService!.refresh();
    await _localExamScheduleService!.refresh();

    final timeEnded = stopwatch.elapsed;

    await Future.delayed(
        timeEnded < minTurnAroundTime ? minTurnAroundTime - timeEnded : const Duration(seconds: 0),
        () {
      _navigator!.pushNamedAndRemoveUntil(Const.defaultPage, (_) => false);
    });
  }

  void defaultCase() {
    if (ModalRoute.of(context)?.settings.name != '/') {
      _navigator!.pushNamedAndRemoveUntil('/', (_) => false);
    }
  }
}
