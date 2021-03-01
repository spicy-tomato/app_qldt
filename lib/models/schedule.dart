class Schedule {
  final String idModuleClass;
  final String moduleName;
  final String idRoom;
  final int shiftSchedules;
  final DateTime daySchedules;

  Schedule({
    this.idModuleClass,
    this.moduleName,
    this.idRoom,
    this.shiftSchedules,
    this.daySchedules,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        idModuleClass: json['ID_Module_Class'],
        moduleName: json['Module_Name'],
        idRoom: json['ID_Room'],
        shiftSchedules: int.parse(json['Shift_Schedules']),
        daySchedules: DateTime.parse(json['Day_Schedules']));
  }

  factory Schedule.fromMap(Map<String, dynamic> map){
    return Schedule(
      idModuleClass: map['Id_Module_Class'],
      moduleName: map['Module_Name'],
      idRoom: map['Id_Room'],
      shiftSchedules: map['Shift_Schedules'],
      daySchedules: DateTime.parse(
        map['Day_Schedules'],
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
