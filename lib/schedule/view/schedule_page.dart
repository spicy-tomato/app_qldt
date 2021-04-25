import 'package:app_qldt/_widgets/user_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_models/meeting_data_source.dart';
import 'package:app_qldt/_models/user_event.dart';
import 'package:app_qldt/_widgets/shared_ui.dart';

import 'local_widgets/schedule.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  _SchedulePageState();

  late var model;
  final UserDataSource _events = UserDataSource(<UserEvent>[]);

  final GlobalKey _globalKey = GlobalKey();
  late Map<DateTime, List<UserEvent>> schedulesData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    schedulesData = UserDataModel.of(context)!.localEventService.eventsData;
    _addData();

    model = Theme.of(context);

    return SharedUI(
      child: Container(
        child: Theme(
          key: _globalKey,
          data: model.copyWith(accentColor: model.backgroundColor),
          child: Schedule(_events),
        ),
      ),
    );
  }

  void _addData() {
    final List<UserEvent> appointment = _getDataSource(schedulesData);

    print('_addData() called');
    _events.appointments!.clear();

    appointment.forEach((element) {
      _events.appointments!.add(element);
    });
  }

  List<UserEvent> _getDataSource(Map<DateTime, List<UserEvent>> schedulesData) {
    final List<UserEvent> events = <UserEvent>[];

    schedulesData.forEach((_, mapValue) {
      mapValue.forEach((element) {
        events.add(element);
      });
    });

    return events;
  }
}
