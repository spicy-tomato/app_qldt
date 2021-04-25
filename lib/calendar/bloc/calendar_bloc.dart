import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState.unknown());

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is CalendarInit) {
      yield _mapCalendarInitToState(event);
    } else if (event is CalendarDaySelected) {
      yield _mapCalendarDaySelectedToState(event);
    } else if (event is CalendarVisibleDayChanged) {
      yield _mapCalendarDayChangedToState(event);
    }
  }

  CalendarState _mapCalendarInitToState(CalendarInit event) {
    return CalendarState.init(event.today, event.todayEvents);
  }

  CalendarState _mapCalendarDaySelectedToState(
    CalendarDaySelected event,
  ) {
    if (state.lastSelectedDay != event.selectedDay) {
      return state.copyWith(
        true,
        visibleDay: event.selectedDay,
        selectedEvents: event.selectedEvents,
        lastSelectedDay: event.selectedDay,
        lastSelectedDayEvents: event.selectedEvents,
      );
    }

    return state.copyWith(false);
  }

  CalendarState _mapCalendarDayChangedToState(
    CalendarVisibleDayChanged event,
  ) {
    return state.copyWith(
      true,
      visibleDay: event.visibleDay,
      selectedEvents: event.visibleDayEvents,
    );
  }
}
