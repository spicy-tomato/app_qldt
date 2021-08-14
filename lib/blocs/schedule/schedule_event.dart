part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class InitializeEvents extends ScheduleEvent {}

class AddEvent extends ScheduleEvent {
  final UserEventModel event;

  const AddEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class ModifyEvent extends ScheduleEvent {
  final EventModel event;

  const ModifyEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class RemoveEvent extends ScheduleEvent {
  final int id;

  const RemoveEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ModifySchedule extends ScheduleEvent {
  final EventScheduleModel event;

  const ModifySchedule(this.event);

  @override
  List<Object?> get props => [event];
}

class ModifyAllSchedulesWithName extends ScheduleEvent {
  final EventScheduleModel event;

  const ModifyAllSchedulesWithName(this.event);

  @override
  List<Object?> get props => [event];
}
