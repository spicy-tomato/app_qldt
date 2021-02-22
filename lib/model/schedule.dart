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

  String toString() {
    return "Mã HP: $idModuleClass, HP: $moduleName";
  }
}
