import 'dart:io';

class Secret {
  static _Url url = _Url();

  static const ANDROID_CLIENT_ID =
      '227524919974-ogjnrouk4pq2cvsgt7jf19nd0h4fio8a.apps.googleusercontent.com';
  static const IOS_CLIENT_ID = '';

  static String getId() => Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}

class _Url {
  _GetRequest getRequest = _GetRequest();
  _PostRequest postRequest = _PostRequest();

  _Url();
}

class _GetRequest {
  const _GetRequest();

  String get schedule =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_schedule.php';

  String get notification =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/notification.php';

  String get score =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_score.php';
}

class _PostRequest {
  const _PostRequest();

  String get upsertToken =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/upsert_token.php';
}
