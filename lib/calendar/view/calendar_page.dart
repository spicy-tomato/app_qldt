import 'package:app_qldt/app/app.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

import 'package:app_qldt/_authentication/authentication.dart';
import 'package:app_qldt/calendar/bloc/calendar_bloc.dart';
import 'package:app_qldt/calendar/view/local_widgets/outsideWeekendDayBuilder.dart';

import 'package:app_qldt/_widgets/interface.dart';
import 'package:app_qldt/_widgets/item.dart';

import 'package:app_qldt/calendar/view/local_widgets/local_widgets.dart';
import 'package:app_qldt/calendar/view/style/style.dart';

extension DateTimeExtexsion on DateTime {
  DateTime get toStandard => DateTime(this.year, this.month, this.day);

  bool isBetween(DateTime before, DateTime after) {
    return this.isAfter(before) && this.isBefore(after);
  }

  bool isTheSameMonth(DateTime dateTime) {
    return this.month == dateTime.month;
  }
}

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  _CalendarPageState();

  @override
  Widget build(BuildContext context) {
    final schedulesData = UserDataModel.of(context)!.localScheduleService.schedulesData;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return FutureBuilder(
          builder: (
            BuildContext context,
            AsyncSnapshot<Map<DateTime, List<dynamic>>> snapshot,
          ) {
            return BlocProvider(
              create: (context) {
                return CalendarBloc();
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Item(
                    child: Calendar(events: schedulesData),
                  ),
                  Interface.mediumBox(),
                  Expanded(
                    child: EventList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class Calendar extends StatefulWidget {
  final Map<DateTime, List> events;

  Calendar({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late CalendarController _calendarController;
  late HeaderStyle _headerStyle;
  late DaysOfWeekStyle _daysOfWeekStyle;

  @override
  void initState() {
    super.initState();

    _headerStyle = headerStyle();
    _daysOfWeekStyle = daysOfWeekStyle();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) {
        return previous.visibleDay != null && previous.visibleDay != current.visibleDay;
      },
      builder: (context, state) {
        return TableCalendar(
          locale: 'vi_VI',
          events: widget.events,
          weekendDays: [DateTime.sunday],
          startingDayOfWeek: StartingDayOfWeek.monday,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          },
          headerStyle: _headerStyle,
          daysOfWeekStyle: _daysOfWeekStyle,
          builders: CalendarBuilders(
            outsideDayBuilder: (context, date, _) {
              return outsideDayWidget(date);
            },
            dayBuilder: (context, date, _) {
              return dayWidget(date);
            },
            selectedDayBuilder: (context, date, _) {
              return selectedDayWidget(date, _animationController);
            },
            todayDayBuilder: (context, date, _) {
              return date.isTheSameMonth(_calendarController.focusedDay)
                  ? todayInNowVisibleWidget(date)
                  : todayOutNowVisibleWidget(date);
            },
            weekendDayBuilder: (context, date, _) {
              return weekendWidget(date);
            },
            outsideWeekendDayBuilder: (context, date, _) {
              return outsideWeekendWidget(date);
            },
            markersBuilder: (context, date, events, holidays) {
              return date.month == _calendarController.focusedDay.month
                  ? dayInNowVisibleMonthMarker(date, events)
                  : dayOutNowVisibleMonthMarker(date, events);
            },
          ),
          calendarController: _calendarController,
          onCalendarCreated: _onCalendarCreated,
          onDaySelected: (date, events, holidays) {
            _onDaySelected(date, events, holidays);
            _animationController.forward(from: 0.0);
          },
          onVisibleDaysChanged: (first, last, format) {
            _onVisibleDaysChanged(first, last, format);
          },
        );
      },
    );
  }

  void _onCalendarCreated(_, __, ___) {
    DateTime today = DateTime.now().toStandard;
    context.read<CalendarBloc>().add(CalendarDaySelected(today, widget.events[today] ?? []));
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    DateTime _selectedDay = day.toStandard;

    context.read<CalendarBloc>().add(CalendarDaySelected(_selectedDay, events));
    _calendarController.setSelectedDay(_selectedDay);
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    DateTime _lastSelectedDay = context.read<CalendarBloc>().state.lastSelectedDay!;

    if (_lastSelectedDay.isBetween(first, last)) {
      DateTime _dayWillBeSelected = _lastSelectedDay.month == _calendarController.focusedDay.month
          ? _lastSelectedDay.toStandard
          : DateTime(_calendarController.focusedDay.year, _calendarController.focusedDay.month, 1);

      _calendarController.setSelectedDay(_dayWillBeSelected);

      context.read<CalendarBloc>().add(CalendarVisibleDayChanged(
          _dayWillBeSelected.toStandard, widget.events[_dayWillBeSelected.toStandard] ?? []));
    } else {
      DateTime _dayWillBeSelected = _calendarController.focusedDay.toStandard;

      context.read<CalendarBloc>().add(
          CalendarVisibleDayChanged(_dayWillBeSelected, widget.events[_dayWillBeSelected] ?? []));

      _calendarController.setSelectedDay(_dayWillBeSelected);
    }
  }
}

class EventList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) => current.buildFirstTime,
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.only(),
          children: _getList(state.selectedEvents),
        );
      },
    );
  }

  List<Widget> _getList(List? selectedEvents) {
    if (selectedEvents == null) {
      return <Widget>[Container()];
    }

    return selectedEvents
        .map(
          (event) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Item(
              child: ListTile(
                title: Text('Ca : ' +
                    event.shiftSchedules.toString() +
                    '\n' +
                    'Phòng: ' +
                    event.idRoom +
                    '\n' +
                    event.moduleName),
                // onTap: () => print('$event tapped!'),
              ),
            ),
          ),
        )
        .toList();
  }
}
