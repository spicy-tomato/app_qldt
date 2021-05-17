import 'package:app_qldt/_widgets/wrapper/item.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_models/meeting_data_source.dart';
import 'package:app_qldt/_models/user_event.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/_widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'local_widgets/schedule.dart';

class SchedulePage extends StatefulWidget {
  final void Function()? onClose;

  const SchedulePage({Key? key, this.onClose}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey _globalKey = GlobalKey();
  final UserDataSource _events = UserDataSource(<UserEvent>[]);

  late ThemeData model;
  late Map<DateTime, List<UserEvent>> schedulesData;
  late CalendarController _controller = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    schedulesData = UserDataModel.of(context).localEventService.eventsData;
    _addData();

    model = Theme.of(context);

    return NavigablePlanPage(
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return SharedUI(
            onWillPop: () {
              if (state.visibility != PlanPageVisibility.close){
                _controller.selectedDate = null;
                context.read<PlanBloc>().add(PlanPageVisibilityChanged(PlanPageVisibility.close));
                return Future.value(false);
              }

              return Future.value(null);
            },
            child: Item(
              child: Theme(
                key: _globalKey,
                data: model.copyWith(accentColor: model.backgroundColor),
                child: Schedule(_events, controller: _controller),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addData() {
    final List<UserEvent> appointment = _getDataSource(schedulesData);

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
