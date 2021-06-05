import 'dart:io';

class Secret {
  static const ANDROID_CLIENT_ID =
      '227524919974-ogjnrouk4pq2cvsgt7jf19nd0h4fio8a.apps.googleusercontent.com';
  static const IOS_CLIENT_ID = '';

  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
