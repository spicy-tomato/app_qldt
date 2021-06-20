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
      _mapRemoveEventToState(event);
    } else if (event is ModifyEvent) {
      await _mapModifyEventToState(event);
    } else if (event is ModifyAllEventsWithName) {
      await _mapModifyAllEventsWithNameToState(event);
    } else if(event is ReloadEvent){
      await _mapEventToState(event);
    }
  }

  void _mapInitializeEventsToState(InitializeEvents event) {
    final List<UserEventModel> events = <UserEventModel>[];
    final UserDataModel userDataModel = _context.read<UserRepository>().userDataModel;

    //  Event
    userDataModel.eventServiceController.eventData.forEach((event) {
      events.add(event);
    });

    //  Schedule
    userDataModel.eventServiceController.scheduleData.forEach((schedule) {
      events.add(schedule);
    });

    //  Exam Schedule
    userDataModel.examScheduleServiceController.examScheduleData.forEach((element) {
      events.add(UserEventModel.fromExamScheduleModel(element));
    });

    state.sourceModel.appointments = events;

    state.sourceModel.notifyListeners(CalendarDataSourceAction.add, state.sourceModel.appointments!);
  }

  Future<void> _mapAddEventToState(AddEvent event) async {
    final newEvent = event.event;
    await _userDataModel.eventServiceController.saveNewEvent(newEvent);
    state.sourceModel.appointments!.add(newEvent);
    state.sourceModel.notifyListeners(CalendarDataSourceAction.add, state.sourceModel.appointments!);
  }

  void _mapRemoveEventToState(RemoveEvent event) {
    state.sourceModel.appointments!.remove(event.event);
    state.sourceModel.notifyListeners(CalendarDataSourceAction.remove, state.sourceModel.appointments!);
  }

  Future<void> _mapModifyEventToState(ModifyEvent event) async {
    final modifiedEventInfo = event.event;
    await _userDataModel.eventServiceController.saveModifiedSchedule(modifiedEventInfo);

    final modifiedEvent = (state.sourceModel.appointments as List<UserEventModel>?)!
        .firstWhere((oldEvent) => (oldEvent).id == modifiedEventInfo.id);
    modifiedEvent.color = modifiedEventInfo.color;
    modifiedEvent.description = modifiedEventInfo.description;
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

  Future<void> _mapModifyAllEventsWithNameToState(ModifyAllEventsWithName event) async {
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


  Future<void> _mapEventToState(ReloadEvent event) async {

    // ignore: non_constant_identifier_names
    final BeforeEvent = event.event;
    await _userDataModel.eventServiceController.saveModifiedEvent(BeforeEvent);

    final newEvent = (state.sourceModel.appointments as List<UserEventModel>?)!
        .firstWhere((oldEvent1) => (oldEvent1).id == BeforeEvent.id);

    newEvent.eventName = BeforeEvent.eventName;
    newEvent.isAllDay = BeforeEvent.isAllDay;
    newEvent.from = BeforeEvent.from;
    newEvent.to = BeforeEvent.to;
    newEvent.color = BeforeEvent.color;
    newEvent.location = BeforeEvent.location;
    newEvent.description = BeforeEvent.description;

    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }

}
