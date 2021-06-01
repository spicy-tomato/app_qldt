class ExamScheduleModel {
  final String semester;
  final String moduleName;
  final int credit;
  final String dateStart;
  final String timeStart;
  final String method;
  final int identificationNumber;
  final String room;

  ExamScheduleModel({
    required this.semester,
    required this.moduleName,
    required this.credit,
    required this.dateStart,
    required this.timeStart,
    required this.method,
    required this.identificationNumber,
    required this.room,
  });

  factory ExamScheduleModel.fromJson(Map<String, dynamic> json) {
    return ExamScheduleModel(
      semester: json['Semester'],
      moduleName: json['Module_Name'],
      credit: json['Credit'],
      dateStart: json['Date_Start'],
      timeStart: json['Time_Start'],
      method: json['Method'],
      identificationNumber: json['Identification_Number'],
      room: json['Room'],
    );
  }

  factory ExamScheduleModel.fromMap(Map<String, dynamic> map) {
    return ExamScheduleModel(
      semester: map['semester'],
      moduleName: map['module_name'],
      credit: map['credit'],
      dateStart: map['date_start'],
      timeStart: map['time_start'],
      method: map['method'],
      identificationNumber: map['identification_number'],
      room: map['room'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'semester': semester,
      'module_name': moduleName,
      'credit': credit,
      'date_start': dateStart,
      'time_start': timeStart,
      'method': method,
      'identification_number': identificationNumber,
      'room': room,
    };
  }

  @override
  String toString() {
    return '$moduleName, $dateStart';
  }

  List toList() {
    return [
      dateStart,
      timeStart,
      identificationNumber,
      room,
      method,
      credit,
    ];
  }
}
