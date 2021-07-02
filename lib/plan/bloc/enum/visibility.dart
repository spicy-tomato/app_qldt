enum PlanPageVisibility {
  close,
  apart,
  open,
}

extension PlanPageVisibilityExtension on PlanPageVisibility {
  bool get isClosed => this == PlanPageVisibility.close;
  bool get isOpened => this == PlanPageVisibility.open;
  bool get isOpenedApart => this == PlanPageVisibility.apart;
}
