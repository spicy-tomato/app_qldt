import 'dart:io';

class Secret {
  static const androidClientId = '227524919974-ogjnrouk4pq2cvsgt7jf19nd0h4fio8a.apps.googleusercontent.com';
  static const iosClientId = '';

  static String getId() => Platform.isAndroid ? Secret.androidClientId : Secret.iosClientId;
}
