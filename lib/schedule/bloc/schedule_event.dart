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

class RemoveEvent extends ScheduleEvent {
  final UserEventModel event;

  const RemoveEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class ModifyEvent extends ScheduleEvent {
  final EventScheduleModel event;

  const ModifyEvent(this.event);

  @override
  List<Object?> get props => [event];
}

class ModifyAllEventsWithName extends ScheduleEvent {
  final EventScheduleModel event;

  const ModifyAllEventsWithName(this.event);

  @override
  List<Object?> get props => [event];
}
class ReloadEvent extends ScheduleEvent{
  final EventModel event;
  const ReloadEvent(this.event);

  @override
  List<Object?> get props => [event];




}
