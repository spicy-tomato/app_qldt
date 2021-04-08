import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

import 'package:app_qldt/_models/event.dart';
import 'package:app_qldt/_widgets/bottom_note/bottom_note.dart';
import 'package:app_qldt/_widgets/shared_ui.dart';
import 'package:app_qldt/_widgets/topbar/topbar.dart';
import 'package:app_qldt/_widgets/user_data_model.dart';

import '../bloc/calendar_bloc.dart';
import '../view/local_widgets/local_widgets.dart';

class CalendarPage extends StatefulWidget {
  final CalendarController calendarController = CalendarController();
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
          schedulesData = await UserDataModel.of(context)!.localEventService.refresh();
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
              ///
              /// Không sửa, vì ở đây cần build từ dưới lên trên (theo hướng màn hình
              /// điện thoại) để _calendarController có thể được khởi tạo
              ///
              /// (CalendarController.init() chỉ được gọi khi TableCalendar được khởi tạo)
              ///
              Column(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      /// _calendarController được khởi tạo ở đây
                      Calendar(
                        events: schedulesData,
                        calendarController: widget.calendarController,
                      ),
                      ValueListenableBuilder(
                        builder: (_, bool value, Widget? child) {
                          return value ? Loading() : Container();
                        },
                        valueListenable: widget.isLoading,
                      ),
                    ],
                  ),
                  CalendarDow(),
                  CalendarHeader(calendarController: widget.calendarController),
                ],
              ),
              Expanded(
                child: BlocBuilder<CalendarBloc, CalendarState>(
                  buildWhen: (previous, current) =>
                      current.buildFirstTime &&
                      !DeepCollectionEquality()
                          .equals(previous.selectedEvents, current.selectedEvents),
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
