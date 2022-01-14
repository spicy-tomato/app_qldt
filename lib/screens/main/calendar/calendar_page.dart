import 'package:app_qldt/blocs/calendar/calendar_bloc.dart';
import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:app_qldt/models/event/user_event_model.dart';
import 'package:app_qldt/repositories/user_repository/user_repository.dart';
import 'package:app_qldt/widgets/component/bottom_note/bottom_note.dart';
import 'package:app_qldt/widgets/component/loading/loading.dart';
import 'package:app_qldt/widgets/component/refresh_button/refresh_button.dart';
import 'package:app_qldt/widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/widgets/wrapper/shared_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

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
            if (!state.visibility.isClosed) {
                context.read<PlanBloc>().add(ClosePlanPage());
                return Future.value(false);
              }

              return Future.value(null);
            },
            topRightWidget: _refreshButton(context),
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
                  const Expanded(child: EventList()),
                  const BottomNote(
                    useCurrentTime: false,
                  ),
                ],
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
        return value ? const Loading() : Container();
      },
      valueListenable: widget.isLoading,
    );
  }
}
