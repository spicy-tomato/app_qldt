import 'package:app_qldt/_repositories/user_repository/src/user_repository.dart';
import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:app_qldt/plan/plan.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_models/user_event_model.dart';
import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';

import '../bloc/calendar_bloc.dart';
import '../view/local_widgets/local_widgets.dart';

class CalendarPage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<UserEventModel>> schedulesData;

  @override
  Widget build(BuildContext context) {
    schedulesData = context.read<UserRepository>().userDataModel.eventServiceController.calendarData;

    return NavigablePlanPage(
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
            topRightWidget: _refreshButton(context),
            child: Container(
              child: BlocProvider<CalendarBloc>(
                create: (_) => CalendarBloc(),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Calendar(events: schedulesData),
                        _fader(),
                      ],
                    ),
                    Expanded(child: EventList()),
                    BottomNote(
                      useCurrentTime: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return RefreshButton(
      onTap: () async {
        widget.isLoading.value = true;

        await context.read<UserRepository>().userDataModel.eventServiceController.refresh();
        schedulesData = context.read<UserRepository>().userDataModel.eventServiceController.calendarData;

        widget.isLoading.value = false;
      },
    );
  }

  Widget _fader() {
    return ValueListenableBuilder<bool>(
      builder: (_, value, __) {
        return value ? Loading() : Container();
      },
      valueListenable: widget.isLoading,
    );
  }
}
