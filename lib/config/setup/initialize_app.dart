part of '../config.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  // var _clientId = new ClientId(Secret.getId(), '');
  // const _scopes = const [];

  Paint.enableDithering = true;

  debugPrint('Running in mode ${AppConfig.mode}');
}
