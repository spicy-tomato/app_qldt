import 'dart:async';
import 'package:app_qldt/_models/event_model.dart';
import 'package:app_qldt/_models/event_schedule_model.dart';
import 'package:app_qldt/_models/meeting_data_source_model.dart';

import 'package:app_qldt/_models/user_data_model.dart';
import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'schedule_event.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final BuildContext _context;
  final UserDataModel _userDataModel;

  ScheduleBloc(BuildContext context)
      : _context = context,
        _userDataModel = context.read<UserRepository>().userDataModel,
        super(ScheduleInitial());

  @override
  Stream<ScheduleState> mapEventToState(
    ScheduleEvent event,
  ) async* {
    if (event is InitializeEvents) {
      _mapInitializeEventsToState(event);
    } else if (event is AddEvent) {
      await _mapAddEventToState(event);
    } else if (event is RemoveEvent) {
      await _mapRemoveEventToState(event);
    } else if (event is ModifyEvent) {
      _mapModifyEventToState(event);
    } else if (event is ModifySchedule) {
      await _mapModifyScheduleToState(event);
    } else if (event is ModifyAllSchedulesWithName) {
      await _mapModifyAllSchedulesWithNameToState(event);
    }
  }

  void _mapInitializeEventsToState(InitializeEvents event) {
    final List<UserEventModel> events = <UserEventModel>[];
    final UserDataModel userDataModel = _context.read<UserRepository>().userDataModel;

    //  Event
    for (var event in userDataModel.eventServiceController.eventData) {
      events.add(event);
    }

    //  Schedule
    for (var schedule in userDataModel.eventServiceController.scheduleData) {
      events.add(schedule);
    }

    //  Exam Schedule
    for (var element in userDataModel.examScheduleServiceController.examScheduleData) {
      events.add(UserEventModel.fromExamScheduleModel(element));
    }

    state.sourceModel.appointments = events;

    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

  Future<void> _mapAddEventToState(AddEvent event) async {
    final newEvent = event.event;
    int? lastId = await _userDataModel.eventServiceController.saveNewEvent(newEvent);

    if (lastId != null) {
      state.sourceModel.appointments!.add(newEvent.withId(lastId));
      state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
    }
  }

  Future<void> _mapRemoveEventToState(RemoveEvent event) async {
    int shouldDeleteEventId = event.id;

    await _userDataModel.eventServiceController.deleteEvent(shouldDeleteEventId);

    (state.sourceModel.appointments as List<UserEventModel>?)!
        .removeWhere((element) => element.id == shouldDeleteEventId && element.type.isEvent);
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

  Future<void> _mapModifyEventToState(ModifyEvent event) async {
    final modifiedEventInfo = event.event;
    await _userDataModel.eventServiceController.saveModifiedEvent(modifiedEventInfo);

    final modifiedEvent = (state.sourceModel.appointments as List<UserEventModel>?)!
        .firstWhere((oldEvent) => (oldEvent).id == modifiedEventInfo.id);
    modifiedEvent.color = modifiedEventInfo.color;
    modifiedEvent.description = modifiedEventInfo.description;
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

  Future<void> _mapModifyScheduleToState(ModifySchedule event) async {
    final modifiedEventInfo = event.event;
    await _userDataModel.eventServiceController.saveModifiedSchedule(modifiedEventInfo);

    final modifiedEvent = (state.sourceModel.appointments as List<UserEventModel>?)!
        .firstWhere((oldEvent) => (oldEvent).id == modifiedEventInfo.id);
    modifiedEvent.color = modifiedEventInfo.color;
    modifiedEvent.description = modifiedEventInfo.description;
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

  Future<void> _mapModifyAllSchedulesWithNameToState(ModifyAllSchedulesWithName event) async {
    final modifiedEventInfo = event.event;
    await _userDataModel.eventServiceController
        .saveAllModifiedScheduleWithName(modifiedEventInfo.eventName, modifiedEventInfo);

    (state.sourceModel.appointments as List<UserEventModel>?)!
        .where((oldEvent) => (oldEvent).eventName == modifiedEventInfo.eventName)
        .forEach((event) {
      event.color = modifiedEventInfo.color;
      event.description = modifiedEventInfo.description;
    });
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }
}
