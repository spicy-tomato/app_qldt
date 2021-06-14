import 'dart:async';
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
  final BuildContext context;

  ScheduleBloc(this.context) : super(ScheduleInitial());

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
    } else if (event is ReloadEvents) {
      _mapReloadEventsToState();
    }
  }

  Stream<ScheduleState> _mapInitializeEventsToState(InitializeEvents event) async* {
    final List<UserEventModel> events = <UserEventModel>[];
    final UserDataModel userDataModel = context.read<UserRepository>().userDataModel;

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

    _mapReloadEventsToState();
  }

  Stream<ScheduleState> _mapAddEventToState(AddEvent event) async* {
    state.sourceModel.appointments!.add(event.event);
    _mapReloadEventsToState();
  }

  Stream<ScheduleState> _mapRemoveEventToState(RemoveEvent event) async* {
    state.sourceModel.appointments!.remove(event.event);
    _mapReloadEventsToState();
  }

  void _mapReloadEventsToState() {
    state.sourceModel.notifyListeners(CalendarDataSourceAction.add, state.sourceModel.appointments!);
  }
}
