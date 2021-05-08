class GetRequest {
  const GetRequest();

  String get schedule =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_schedule.php';

  String get notification =>
      'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/notification.php';

  String get score => 'https://utcstudentapp.000webhostapp.com/utcapi/api-v2/client/get_score.php';
}
