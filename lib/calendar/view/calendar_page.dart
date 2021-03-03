import 'package:app_qldt/authentication/authentication.dart';
import 'package:app_qldt/calendar/bloc/calendar_bloc.dart';
import 'package:app_qldt/calendar/view/local_widgets/outsideWeekendDayBuilder.dart';
import 'package:app_qldt/models/schedule.dart';
import 'package:app_qldt/services/offline_calendar_service.dart';
import 'package:app_qldt/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:app_qldt/widgets/item.dart';
import 'package:app_qldt/services/calendar_service.dart';
import 'package:firebase_repository/firebase_repository.dart';

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
  final String studentId;
  final FirebaseRepository firebaseRepository;

  CalendarPage({
    Key key,
    @required this.studentId,
    @required this.firebaseRepository,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Future<Map<DateTime, List<dynamic>>> data;

  @override
  void initState() {
    data = _overallFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return FutureBuilder(
          future: data,
          builder: (BuildContext context,
              AsyncSnapshot<Map<DateTime, List<dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return BlocProvider(
              create: (context) {
                return CalendarBloc();
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Item(
                    child: Calendar(events: snapshot.data),
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

  Future<Map<DateTime, List<dynamic>>> _overallFuture() async {
    await TokenService.upsert(widget.firebaseRepository, widget.studentId);
    return await _getSchedule();
  }

  Future<Map<DateTime, List<dynamic>>> _getSchedule() async {
    List<Schedule> rawData =
        await CalenderService.getRawCalendarData(widget.studentId);

    if (rawData != null) {
      await OfflineCalendarService.removeSavedCalendar();
      await OfflineCalendarService.saveCalendar(rawData);
    }

    return OfflineCalendarService.getCalendar();
  }
}

class Calendar extends StatefulWidget {
  final Map<DateTime, List> events;

  Calendar({
    Key key,
    @required this.events,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  HeaderStyle _headerStyle;
  DaysOfWeekStyle _daysOfWeekStyle;

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
      buildWhen: (previous, current) =>
          previous.visibleDay != current.visibleDay,
      builder: (context, state) {
        return _buildCalendar();
      },
    );
  }

  Widget _buildCalendar() {
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
  }

  void _onCalendarCreated(_, __, ___) {
    DateTime today = DateTime.now().toStandard;
    context
        .read<CalendarBloc>()
        .add(CalendarDaySelected(today, widget.events[today] ?? []));
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    DateTime _selectedDay = day.toStandard;

    context.read<CalendarBloc>().add(CalendarDaySelected(_selectedDay, events));
    _calendarController.setSelectedDay(_selectedDay);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    DateTime _lastSelectedDay =
        context.read<CalendarBloc>().state.lastSelectedDay;

    if (_lastSelectedDay.isBetween(first, last)) {
      DateTime _dayWillBeSelected =
          _lastSelectedDay.month == _calendarController.focusedDay.month
              ? _lastSelectedDay.toStandard
              : DateTime(_calendarController.focusedDay.year,
                  _calendarController.focusedDay.month, 1);

      _calendarController.setSelectedDay(_dayWillBeSelected);

      context.read<CalendarBloc>().add(CalendarVisibleDayChanged(
          _dayWillBeSelected.toStandard,
          widget.events[_dayWillBeSelected.toStandard] ?? []));
    } else {
      DateTime _dayWillBeSelected = _calendarController.focusedDay.toStandard;

      context.read<CalendarBloc>().add(CalendarVisibleDayChanged(
          _dayWillBeSelected, widget.events[_dayWillBeSelected] ?? []));

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
      // buildWhen: (previous, current) =>
      //     previous.visibleDay != previous.visibleDay,
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.only(),
          children: getList(state.selectedEvents),
        );
      },
    );
  }

  List<Widget> getList(List selectedEvents) {
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
