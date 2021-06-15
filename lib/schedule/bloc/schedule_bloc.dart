import 'dart:async';
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
      yield* _mapInitializeEventsToState(event);
    } else if (event is AddEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is RemoveEvent) {
      yield* _mapRemoveEventToState(event);
    } else if (event is ModifyEvent) {
      yield* _mapModifyEventToState(event);
    }
  }

  Stream<ScheduleState> _mapInitializeEventsToState(InitializeEvents event) async* {
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

  Stream<ScheduleState> _mapAddEventToState(AddEvent event) async* {
    final newEvent = event.event;

    await _userDataModel.eventServiceController.saveNewEvent(newEvent);
    state.sourceModel.appointments!.add(newEvent);
    state.sourceModel.notifyListeners(CalendarDataSourceAction.add, state.sourceModel.appointments!);
  }

  Stream<ScheduleState> _mapRemoveEventToState(RemoveEvent event) async* {
    state.sourceModel.appointments!.remove(event.event);
    state.sourceModel.notifyListeners(CalendarDataSourceAction.remove, state.sourceModel.appointments!);
  }

  Stream<ScheduleState> _mapModifyEventToState(ModifyEvent event) async* {
    final modifiedEventInfo = event.event;
    await _userDataModel.eventServiceController.saveModifiedSchedule(modifiedEventInfo);

    final modifiedEvent = (state.sourceModel.appointments!
            .firstWhere((oldEvent) => (oldEvent as UserEventModel).id == modifiedEventInfo.id)
        as UserEventModel);
    modifiedEvent.color = modifiedEventInfo.color;
    modifiedEvent.description = modifiedEventInfo.description;
    state.sourceModel.notifyListeners(CalendarDataSourceAction.reset, state.sourceModel.appointments!);
  }
}
