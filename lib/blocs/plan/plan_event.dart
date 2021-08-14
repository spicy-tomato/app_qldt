part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class PlanTitleChanged extends PlanEvent {
  final String title;

  const PlanTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class PlanIsAllDayChanged extends PlanEvent {}

class PlanFromDateChanged extends PlanEvent {
  final DateTime from;

  const PlanFromDateChanged(this.from);

  @override
  List<Object> get props => [from];
}

class PlanToDateChanged extends PlanEvent {
  final DateTime to;

  const PlanToDateChanged(this.to);

  @override
  List<Object> get props => [to];
}

class PlanRepeatChanged extends PlanEvent {
  final PlanRepeat repeat;

  const PlanRepeatChanged(this.repeat);

  @override
  List<Object> get props => [repeat];
}

class PlanPeopleChanged extends PlanEvent {
  final String people;

  const PlanPeopleChanged(this.people);

  @override
  List<Object> get props => [people];
}

class PlanDescriptionChanged extends PlanEvent {
  final String description;

  const PlanDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class PlanAccessibilityChanged extends PlanEvent {
  final PlanAccessibility accessibility;

  const PlanAccessibilityChanged(this.accessibility);

  @override
  List<Object> get props => [accessibility];
}

class PlanStatusChanged extends PlanEvent {
  final PlanStatus status;

  const PlanStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class PlanColorChanged extends PlanEvent {
  final PlanColors color;

  const PlanColorChanged(this.color);

  @override
  List<Object> get props => [color];
}

class PlanLocationChanged extends PlanEvent {
  final String location;

  const PlanLocationChanged(this.location);

  @override
  List<Object> get props => [location];
}

class OpenPlanPage extends PlanEvent {
  final PlanType? type;

  const OpenPlanPage({this.type});

  @override
  List<Object> get props => [type!];
}

class ClosePlanPage extends PlanEvent {}

class PlanTimeChangedToCurrentTime extends PlanEvent {
  final DateTime current = DateTime.now();

  PlanTimeChangedToCurrentTime();

  @override
  List<Object> get props => [current];
}

class ShowApartPlanPage extends PlanEvent {
  final DateTime dateTime;

  const ShowApartPlanPage(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}

class EditSchedule extends PlanEvent {
  final UserEventModel event;

  const EditSchedule(this.event);

  @override
  List<Object> get props => [event];
}

class EditEvent extends PlanEvent {
  final UserEventModel event;

  const EditEvent(this.event);

  @override
  List<Object> get props => [event];
}
