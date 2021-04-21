class Schedule {
  final String idModuleClass;
  final String moduleName;
  final String idRoom;
  final int shiftSchedules;
  final DateTime daySchedules;

  Schedule({
    required this.idModuleClass,
    required this.moduleName,
    required this.idRoom,
    required this.shiftSchedules,
    required this.daySchedules,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      idModuleClass: json['ID_Module_Class'],
      moduleName: json['Module_Name'],
      idRoom: json['ID_Room'],
      shiftSchedules: json['Shift_Schedules'],
      daySchedules: DateTime.parse(json['Day_Schedules']),
    );
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      idModuleClass: map['id_module_class'],
      moduleName: map['module_name'],
      idRoom: map['id_room'],
      shiftSchedules: map['shift_schedules'],
      daySchedules: DateTime.parse(
        map['day_schedules'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id_Module_Class': idModuleClass,
      'Module_Name': moduleName,
      'Id_Room': idRoom,
      'Shift_Schedules': shiftSchedules,
      'Day_Schedules': daySchedules.toIso8601String(),
    };
  }

  String toString() {
    return "Mã HP: $idModuleClass, HP: $moduleName";
  }
}
