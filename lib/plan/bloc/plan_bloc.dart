import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'enum/enum.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  // TODO: Do we need this?
  PlanBloc({DateTime? from, DateTime? to})
      : super(
          PlanState(
              fromDay: from ?? DateTime.now(),
              toDay: from != null
                  ? from.add(Duration(hours: 3))
                  : DateTime.now().add(Duration(hours: 3))),
        );

  @override
  Stream<PlanState> mapEventToState(
    PlanEvent event,
  ) async* {
    if (event is PlanTitleChanged) {
      yield _mapPlanTitleChangedToState(event, state);
    } else if (event is PlanIsAllDayChanged) {
      yield (_mapPlanIsAllDayChangedToState(state));
    } else if (event is PlanFromDateChanged) {
      yield (_mapPlanFromDateChangedToState(event, state));
    } else if (event is PlanToDateChanged) {
      yield (_mapPlanToDateChangedToState(event, state));
    } else if (event is PlanRepeatChanged) {
      yield (_mapPlanRepeatChangedToState(event, state));
    } else if (event is PlanPeopleChanged) {
      yield (_mapPlanPeopleChangedToState(event, state));
    } else if (event is PlanDescriptionChanged) {
      yield (_mapPlanDescriptionChangedToState(event, state));
    } else if (event is PlanAccessibilityChanged) {
      yield (_mapPlanAccessibilityChangedToState(event, state));
    } else if (event is PlanStatusChanged) {
      yield (_mapPlanStatusChangedToState(event, state));
    } else if (event is PlanColorChanged) {
      yield (_mapPlanColorChangedToState(event, state));
    }
  }

  PlanState _mapPlanTitleChangedToState(
    PlanTitleChanged event,
    PlanState state,
  ) {
    return state.copyWith(title: event.title);
  }

  PlanState _mapPlanIsAllDayChangedToState(PlanState state) {
    return state.copyWith(isAllDay: !state.isAllDay);
  }

  PlanState _mapPlanFromDateChangedToState(
    PlanFromDateChanged event,
    PlanState state,
  ) {
    return state.copyWith(from: event.from);
  }

  PlanState _mapPlanToDateChangedToState(
    PlanToDateChanged event,
    PlanState state,
  ) {
    return state.copyWith(to: event.to);
  }

  PlanState _mapPlanRepeatChangedToState(PlanRepeatChanged event, PlanState state) {
    return state.copyWith(repeat: event.repeat);
  }

  PlanState _mapPlanPeopleChangedToState(
    PlanPeopleChanged event,
    PlanState state,
  ) {
    return state.copyWith(people: event.people);
  }

  PlanState _mapPlanDescriptionChangedToState(
    PlanDescriptionChanged event,
    PlanState state,
  ) {
    return state.copyWith(description: event.description);
  }

  PlanState _mapPlanAccessibilityChangedToState(
    PlanAccessibilityChanged event,
    PlanState state,
  ) {
    return state.copyWith(accessibility: event.accessibility);
  }

  PlanState _mapPlanStatusChangedToState(
    PlanStatusChanged event,
    PlanState state,
  ) {
    return state.copyWith(status: event.status);
  }

  PlanState _mapPlanColorChangedToState(
    PlanColorChanged event,
    PlanState state,
  ) {
    return state.copyWith(color: event.color);
  }
}
