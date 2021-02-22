import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_qldt/model/schedule.dart';

const baseUrl =
'https://ancolincode.000webhostapp.com/utcapi/api-v2/client/get_schedule.php?id=';

Future<List> fetchData(String studentId) async {
  String url = baseUrl + studentId;
  final responseData = await http.get(url);

  if (responseData.statusCode == 200) {
    List data = jsonDecode(responseData.body) as List;
    List<Schedule> listModel = [];
    data.forEach((element) {
      // print(element);
      listModel.add(Schedule.fromJson(element));
    });
    return listModel;
  } else {
    print("Cannot get");
    throw Exception("Failed to load data");
  }
}

Future<Map<DateTime, List>> getData(String studentId) async {
  try {
    List<Schedule> data = (await fetchData(studentId)) as List<Schedule>;
    Map<DateTime, List> events = new Map();

    data.forEach((schedule) {
      if (events[schedule.daySchedules] == null) {
        events[schedule.daySchedules] = new List();
      }
      events[schedule.daySchedules].add(schedule);
    });

    return events;
  } catch (Exception) {
    throw Exception('Cannot parse date');
  }
}
