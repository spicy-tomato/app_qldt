class ScheduleModel {
  final int id;
  final String idModuleClass;
  final String moduleClassName;
  final String idRoom;
  final int shiftSchedules;
  final DateTime daySchedules;

  const ScheduleModel({
    required this.id,
    required this.idModuleClass,
    required this.moduleClassName,
    required this.idRoom,
    required this.shiftSchedules,
    required this.daySchedules,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['ID_Schedules'],
      idModuleClass: json['ID_Module_Class'],
      moduleClassName: json['Module_Class_Name'],
      idRoom: json['ID_Room'],
      shiftSchedules: json['Shift_Schedules'],
      daySchedules: DateTime.parse(json['Day_Schedules']),
    );
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id_schedule'],
      idModuleClass: map['id_module_class'],
      moduleClassName: map['module_class_name'],
      idRoom: map['id_room'],
      shiftSchedules: map['shift_schedules'],
      daySchedules: DateTime.parse(map['day_schedules']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_schedule': id,
      'id_module_class': idModuleClass,
      'module_class_name': moduleClassName,
      'id_room': idRoom,
      'shift_schedules': shiftSchedules,
      'day_schedules': daySchedules.toIso8601String(),
    };
  }

  String toString() {
    return 'Mã HP: $idModuleClass, HP: $moduleClassName, id: $id';
  }
}
