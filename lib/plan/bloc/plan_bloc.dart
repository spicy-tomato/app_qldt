import 'dart:async';

import 'package:app_qldt/_models/user_event_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'enum/enum.dart';

export 'enum/enum.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc() : super(PlanState(fromDay: DateTime.now(), toDay: DateTime.now()));

  @override
  Stream<PlanState> mapEventToState(
    PlanEvent event,
  ) async* {
    if (event is PlanTitleChanged) {
      yield _mapPlanTitleChangedToState(event);
    } else if (event is PlanIsAllDayChanged) {
      yield _mapPlanIsAllDayChangedToState();
    } else if (event is PlanFromDateChanged) {
      yield _mapPlanFromDateChangedToState(event);
    } else if (event is PlanToDateChanged) {
      yield _mapPlanToDateChangedToState(event);
    } else if (event is PlanRepeatChanged) {
      yield _mapPlanRepeatChangedToState(event);
    } else if (event is PlanPeopleChanged) {
      yield _mapPlanPeopleChangedToState(event);
    } else if (event is PlanDescriptionChanged) {
      yield _mapPlanDescriptionChangedToState(event);
    } else if (event is PlanAccessibilityChanged) {
      yield _mapPlanAccessibilityChangedToState(event);
    } else if (event is PlanStatusChanged) {
      yield _mapPlanStatusChangedToState(event);
    } else if (event is PlanColorChanged) {
      yield _mapPlanColorChangedToState(event);
    } else if (event is PlanTimeChangedToCurrentTime) {
      yield _mapPlanChangedToCurrentTimeToState(event);
    } else if (event is ShowApartPlanPage) {
      yield _mapShowApartPlanPageToState(event);
    } else if (event is EditEvent) {
      yield _mapEditEventToState(event);
    } else if (event is OpenPlanPage) {
      yield _mapOpenPlanPageToState();
    } else if (event is ClosePlanPage) {
      yield _mapClosePlanPageToState();
    }
  }

  PlanState _mapPlanTitleChangedToState(PlanTitleChanged event) {
    return state.copyWith(title: event.title);
  }

  PlanState _mapPlanIsAllDayChangedToState() {
    return state.copyWith(isAllDay: !state.isAllDay);
  }

  PlanState _mapPlanFromDateChangedToState(PlanFromDateChanged event) {
    return state.copyWith(from: event.from);
  }

  PlanState _mapPlanToDateChangedToState(PlanToDateChanged event) {
    return state.copyWith(to: event.to);
  }

  PlanState _mapPlanRepeatChangedToState(PlanRepeatChanged event) {
    return state.copyWith(repeat: event.repeat);
  }

  PlanState _mapPlanPeopleChangedToState(PlanPeopleChanged event) {
    return state.copyWith(people: event.people);
  }

  PlanState _mapPlanDescriptionChangedToState(PlanDescriptionChanged event) {
    return state.copyWith(description: event.description);
  }

  PlanState _mapPlanAccessibilityChangedToState(PlanAccessibilityChanged event) {
    return state.copyWith(accessibility: event.accessibility);
  }

  PlanState _mapPlanStatusChangedToState(PlanStatusChanged event) {
    return state.copyWith(status: event.status);
  }

  PlanState _mapPlanColorChangedToState(PlanColorChanged event) {
    return state.copyWith(color: event.color);
  }

  PlanState _mapPlanChangedToCurrentTimeToState(PlanTimeChangedToCurrentTime event) {
    return state.copyWith(
      from: event.current,
      to: event.current.add(Duration(hours: 1)),
    );
  }

  PlanState _mapShowApartPlanPageToState(ShowApartPlanPage event) {
    return state.copyWith(
      from: event.dateTime,
      to: event.dateTime.add(Duration(hours: 1)),
      visibility: PlanPageVisibility.apart,
    );
  }

  PlanState _mapEditEventToState(EditEvent event) {
    return state.copyWith(
      from: event.event.from,
      to: event.event.to,
      color: event.event.backgroundColor,
      location: event.event.location,
      visibility: PlanPageVisibility.open,
    );
  }

  PlanState _mapOpenPlanPageToState() {
    return state.copyWith(visibility: PlanPageVisibility.open);
  }

  PlanState _mapClosePlanPageToState() {
    return state.copyWith(visibility: PlanPageVisibility.close);
  }
}
