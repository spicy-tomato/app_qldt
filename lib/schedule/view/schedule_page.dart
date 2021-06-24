import 'package:app_qldt/_widgets/wrapper/item.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:app_qldt/schedule/bloc/schedule_bloc.dart';
import 'package:flutter/material.dart';

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
  final CalendarController _controller = CalendarController();
  late ThemeData _themeModel;

  @override
  Widget build(BuildContext context) {
    _themeModel = Theme.of(context);

    return BlocProvider<ScheduleBloc>(
      create: (_) => ScheduleBloc(context)..add(InitializeEvents()),
      child: NavigablePlanPage(
        onPanelClose: _onPanelClose,
        child: BlocBuilder<PlanBloc, PlanState>(
          builder: (context, state) {
            return SharedUI(
              onWillPop: () {
                if (state.visibility != PlanPageVisibility.close) {
                  context.read<PlanBloc>().add(ClosePlanPage());
                  return Future.value(false);
                }

                return Future.value(null);
              },
              child: Item(
                child: Theme(
                  key: _globalKey,
                  data: _themeModel.copyWith(accentColor: _themeModel.backgroundColor),
                  child: BlocBuilder<ScheduleBloc, ScheduleState>(
                    builder: (context, state) {
                      return Schedule(state.sourceModel, controller: _controller);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanelClose() {
    _controller.selectedDate = null;
  }
}
