part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

// ignore: todo
//  TODO: Remove CalendarInit
class CalendarInit extends CalendarEvent {
  final DateTime today;
  final List todayEvents;

  CalendarInit(this.today, this.todayEvents);

  @override
  List<Object> get props => [today, todayEvents];
}

class CalendarDaySelected extends CalendarEvent {
  final DateTime selectedDay;
  final List selectedEvents;

  CalendarDaySelected(this.selectedDay, this.selectedEvents);

  @override
  List<Object> get props => [selectedDay, selectedEvents];
}

class CalendarVisibleDayChanged extends CalendarEvent {
  final DateTime visibleDay;
  final List visibleDayEvents;

  CalendarVisibleDayChanged(this.visibleDay, this.visibleDayEvents);

  @override
  List<Object> get props => [visibleDay, visibleDayEvents];
}
