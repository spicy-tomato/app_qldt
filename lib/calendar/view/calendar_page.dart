import 'package:app_qldt/_widgets/bottom_note/view/bottom_note.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_models/user_event.dart';
import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/shared_ui.dart';
import 'package:app_qldt/_widgets/topbar/topbar.dart';
import 'package:app_qldt/_widgets/user_data_model.dart';

import '../bloc/calendar_bloc.dart';
import '../view/local_widgets/local_widgets.dart';

class CalendarPage extends StatefulWidget {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<UserEvent>> schedulesData =
        UserDataModel.of(context)!.localEventService.eventsData;

    return SharedUI(
      topRightWidget: RefreshButton(
        context,
        () async {
          widget.isLoading.value = true;

          await UserDataModel.of(context)!.localEventService.refresh();
          schedulesData = UserDataModel.of(context)!.localEventService.eventsData;

          widget.isLoading.value = false;
        },
      ),
      child: Container(
        child: BlocProvider(
          create: (_) {
            return CalendarBloc();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Calendar(events: schedulesData),
                  ValueListenableBuilder(
                    builder: (_, bool value, Widget? child) {
                      return value ? Loading() : Container();
                    },
                    valueListenable: widget.isLoading,
                  ),
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
    );
  }
}

class RefreshButton extends TopBarItem {
  final GestureTapCallback onTap;
  final BuildContext context;

  RefreshButton(this.context, this.onTap)
      : super(
          onTap: onTap,
          alignment: Alignment(0.95, 0),
          icon: Icons.refresh,
        );
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animation;
  late bool shouldClose = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = ColorTween(
      begin: Colors.transparent,
      end: Colors.white.withOpacity(0.3),
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: animation.value,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
