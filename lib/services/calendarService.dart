import 'package:http/http.dart' as http;
import 'dart:convert';

const url =
    'https://ancolincode.000webhostapp.com/utcapi/api-v2/tkb.php?id=V181613655';

Future<List> fetchData() async {
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
    throw Exception("Failed to load album");
  }
}

Future<Map<DateTime, List>> getData() async {
  try {
    List<Schedule> data = (await fetchData()) as List<Schedule>;
    Map<DateTime, List> events = new Map();

    data.forEach((schedule) {
      if (events[schedule.daySchedules] == null) {
        events[schedule.daySchedules] = new List();
      }
      events[schedule.daySchedules].add(schedule.moduleClassName);
    });

    return events;
  } catch (Exception) {
    throw Exception('Cannot parse date');
  }
}

class Schedule {
  final String idModuleClass;
  final String moduleClassName;
  final String idRoom;
  final int shiftSchedules;
  final DateTime daySchedules;

  Schedule({this.daySchedules,
    this.idModuleClass,
    this.idRoom,
    this.moduleClassName,
    this.shiftSchedules});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        idModuleClass: json['ID_Module_Class'],
        moduleClassName: json['Module_Class_Name'],
        idRoom: json['ID_Room'],
        shiftSchedules: int.parse(json['Shift_Schedules']),
        daySchedules: DateTime.parse(json['Day_Schedules']));
  }

  String toString() {
    return "Mã HP: $idModuleClass, HP: $moduleClassName";
  }
}

// void main() async {
//   try {
//     List<Schedule> res = (await getData()) as List<Schedule>;
//     res.forEach((element) => print(element.toString()));
//
//     List<Schedule> futureSchedule = await getData();
//     Map<DateTime, List> _events = new Map();
//
//     futureSchedule.forEach((schedule) {
//       if (_events[schedule.daySchedules] == null) {
//         _events[schedule.daySchedules] = new List();
//       }
//       _events[schedule.daySchedules].add(schedule.moduleClassName);
//     });
//
//     print(_events);
//   } catch (Exception) {
//     print("Error");
//   }
// }
