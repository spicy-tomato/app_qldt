import 'dart:async';

import 'package:app_qldt/enums/plan/plan_enum.dart';
import 'package:app_qldt/models/event/user_event_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

export 'package:app_qldt/enums/plan/plan_enum.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PanelController panelController;

  PlanBloc(
    BuildContext context, {
    required this.panelController,
  }) : super(PlanState(fromDay: DateTime.now(), toDay: DateTime.now()));

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
    } else if (event is PlanLocationChanged) {
      yield _mapPlanLocationChangedToState(event);
    } else if (event is PlanTimeChangedToCurrentTime) {
      yield _mapPlanChangedToCurrentTimeToState(event);
    } else if (event is ShowApartPlanPage) {
      yield* _mapShowApartPlanPageToState(event);
    } else if (event is EditSchedule) {
      yield* _mapEditScheduleToState(event);
    } else if (event is EditEvent) {
      yield* _mapEditEventToState(event);
    } else if (event is OpenPlanPage) {
      yield* _mapOpenPlanPageToState(event);
    } else if (event is ClosePlanPage) {
      yield* _mapClosePlanPageToState();
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

  PlanState _mapPlanLocationChangedToState(PlanLocationChanged event) {
    return state.copyWith(location: event.location);
  }

  PlanState _mapPlanChangedToCurrentTimeToState(PlanTimeChangedToCurrentTime event) {
    return state.copyWith(
      from: event.current,
      to: event.current.add(const Duration(hours: 1)),
    );
  }

  Stream<PlanState> _mapShowApartPlanPageToState(ShowApartPlanPage event) async* {
    yield state.copyWith(
      from: event.dateTime,
      to: event.dateTime.add(const Duration(hours: 1)),
      visibility: PlanPageVisibility.apart,
    );

    await panelController.animatePanelToPosition(0.3);
  }

  Stream<PlanState> _mapEditScheduleToState(EditSchedule event) async* {
    final newEvent = event.event;

    yield state.copyWith(
      id: newEvent.id,
      title: newEvent.eventName,
      color: newEvent.color,
      visibility: PlanPageVisibility.open,
      from: newEvent.from,
      to: newEvent.to,
      location: newEvent.location,
      type: PlanType.editSchedule,
    );

    await panelController.open();
  }

  Stream<PlanState> _mapEditEventToState(EditEvent event) async* {
    final newEvent = event.event;

    yield state.copyWith(
      id: newEvent.id,
      title: newEvent.eventName,
      color: newEvent.color,
      from: newEvent.from,
      to: newEvent.to,
      location: newEvent.location,
      visibility: PlanPageVisibility.open,
      type: PlanType.editEvent,
    );

    await panelController.open();
  }

  Stream<PlanState> _mapOpenPlanPageToState(OpenPlanPage event) async* {
    yield state.copyWith(
      title: '',
      color: PlanColors.defaultColor,
      location: '',
      description: '',
      isAllDay: false,
      repeat: PlanRepeat.noRepeat,
      visibility: PlanPageVisibility.open,
      type: event.type ?? PlanType.create,
    );

    await panelController.open();
  }

  Stream<PlanState> _mapClosePlanPageToState() async* {
    yield state.copyWith(visibility: PlanPageVisibility.close);
    await panelController.close();
  }
}
