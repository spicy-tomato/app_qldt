enum PlanType {
  editSchedule,
  editEvent,
  create,
}

extension PlanTypeExtension on PlanType {
  bool get isEditSchedule => this == PlanType.editSchedule;
}
