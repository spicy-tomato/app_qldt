part of '../config.dart';

Future<void> initializeApp() async {
  await dotenv.load(fileName: '.env');
  debugPrint(dotenv.env['RELEASE_URL']);

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  HttpOverrides.global = MyHttpOverrides();

  Paint.enableDithering = true;

  debugPrint('Running in mode ${AppConfig.mode}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}
