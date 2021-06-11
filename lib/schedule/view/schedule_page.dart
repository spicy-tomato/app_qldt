import 'package:app_qldt/_repositories/user_repository/user_repository.dart';
import 'package:app_qldt/_widgets/wrapper/item.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/material.dart';

import 'package:app_qldt/_models/meeting_data_source_model.dart';
import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_models/user_data_model.dart';
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
  final UserDataSourceModel _events = UserDataSourceModel(<UserEventModel>[]);
  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _addData();
    final ThemeData themeModel = Theme.of(context);

    return NavigablePlanPage(
      onPanelClose: _onPanelClose,
      child: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          return SharedUI(
            onWillPop: () {
              if (state.visibility != PlanPageVisibility.close) {
                _controller.selectedDate = null;
                context.read<PlanBloc>().add(ClosePlanPage());
                return Future.value(false);
              }

              return Future.value(null);
            },
            child: Item(
              child: Theme(
                key: _globalKey,
                data: themeModel.copyWith(accentColor: themeModel.backgroundColor),
                child: Schedule(_events, controller: _controller),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addData() {
    final List<UserEventModel> appointment = _getDataSource();

    _events.appointments!.clear();

    appointment.forEach((element) {
      _events.appointments!.add(element);
    });
  }

  List<UserEventModel> _getDataSource() {
    final List<UserEventModel> events = <UserEventModel>[];
    final UserDataModel userDataModel = context.read<UserRepository>().userDataModel;

    //  Schedule
    userDataModel.eventServiceController.eventsData.forEach((_, mapValue) {
      mapValue.forEach((element) {
        events.add(element);
      });
    });

    //  Exam Schedule
    userDataModel.examScheduleServiceController.examScheduleData.forEach((element) {
      events.add(UserEventModel.fromExamScheduleModel(element));
    });

    return events;
  }

  void _onPanelClose() {
    _controller.selectedDate = null;
  }
}
