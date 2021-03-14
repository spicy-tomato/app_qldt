import 'package:app_qldt/topbar/topbar.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_qldt/_widgets/shared_ui.dart';
import 'package:app_qldt/_widgets/user_data_model.dart';

import '../bloc/calendar_bloc.dart';
import '../view/local_widgets/local_widgets.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final schedulesData = UserDataModel.of(context)!.localEventService.eventsData;

    return SharedUI(
      topRightWidget: RefreshButton(context),
      child: FutureBuilder(
        builder: (_, AsyncSnapshot<Map<DateTime, List<dynamic>>> snapshot) {
          return Container(
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
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      /// _calendarController được khởi tạo ở đây
                      Calendar(
                        events: schedulesData,
                        calendarController: _calendarController,
                      ),
                      CalendarDow(),
                      CalendarHeader(calendarController: _calendarController),
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
                  BottomNote(calendarController: _calendarController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RefreshButton extends TopBarItem {
  final BuildContext context;

  RefreshButton(this.context)
      : super(
          onTap: () async => UserDataModel.of(context)!.localEventService.refresh(),
          alignment: Alignment(0.95, 0),
          icon: Icons.refresh,
        );
}
