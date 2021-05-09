import 'package:app_qldt/_widgets/element/loading.dart';
import 'package:app_qldt/_widgets/element/refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_models/user_event.dart';
import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/wrapper/navigable_plan_page.dart';
import 'package:app_qldt/_widgets/wrapper/shared_ui.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';

import '../bloc/calendar_bloc.dart';
import '../view/local_widgets/local_widgets.dart';

class CalendarPage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<UserEvent>> schedulesData;

  @override
  Widget build(BuildContext context) {
    schedulesData = UserDataModel.of(context)!.localEventService.eventsData;

    return NavigablePlanPage(
      child: SharedUI(
        topRightWidget: _refreshButton(context),
        child: Container(
          child: BlocProvider<CalendarBloc>(
            create: (_) {
              return CalendarBloc();
            },
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Calendar(events: schedulesData),
                    _fader(),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<CalendarBloc, CalendarState>(
                    buildWhen: (previous, current) {
                      return current.buildFirstTime &&
                          !DeepCollectionEquality().equals(
                            previous.selectedEvents,
                            current.selectedEvents,
                          );
                    },
                    builder: (_, state) {
                      return EventList(event: state.selectedEvents);
                    },
                  ),
                ),
                BottomNote(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return RefreshButton(
      context,
      onTap: () async {
        widget.isLoading.value = true;

        await UserDataModel.of(context)!.localEventService.refresh();
        schedulesData = UserDataModel.of(context)!.localEventService.eventsData;

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