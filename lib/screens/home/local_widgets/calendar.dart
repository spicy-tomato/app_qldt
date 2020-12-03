import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:app_qldt/widgets/item.dart';
import 'package:app_qldt/utils/const.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 11, 22): ['Easter Monday'],
};

bool dateIsBetween(DateTime date, DateTime before, DateTime after) {
  return date.isAfter(before) && date.isBefore(after);
}

class Calendar extends StatefulWidget {
  Calendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _lastSelectedDay;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    final _selectedDay =
        DateTime.utc(now.year, now.month, now.day, 12, 0, 0, 0);

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: [
        'Event A7',
        'Event B7',
        'Event C7',
        'Event D7',
        'Event E7'
      ],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 4)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();

    _lastSelectedDay = _selectedDay;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
      _lastSelectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    if (dateIsBetween(_lastSelectedDay, first, last)) {
      DateTime _dayWillBeSelected =
          _lastSelectedDay.month == _calendarController.focusedDay.month
              ? _lastSelectedDay
              : DateTime(_calendarController.focusedDay.year,
                  _calendarController.focusedDay.month, 1);
      setState(() {
        _selectedEvents = _events[_dayWillBeSelected] ?? [];
        _calendarController.setSelectedDay(_dayWillBeSelected);
      });
    } else {
      DateTime _dayWillBeSelected = format == CalendarFormat.month
          ? _calendarController.focusedDay
          : first;
      setState(() {
        _selectedEvents = _events[_dayWillBeSelected] ?? [];
        _calendarController.setSelectedDay(_dayWillBeSelected);
      });
    }
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Item(
            child: _buildCalendar(),
          ),
          Interface.mediumBox(),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      locale: 'vi_VI',
      events: _events,
      holidays: _holidays,
      weekendDays: [DateTime.sunday],
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        headerMargin: EdgeInsets.only(bottom: Const.calendarHeaderMarginBottom),
        titleTextStyle: TextStyle(
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarTextColor,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarWeekdayOfWeek,
        ),
        weekendStyle: TextStyle(
          fontSize: Const.calendarDayFontSize,
          color: Const.calendarWeekendOfWeek,
        ),
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Container(
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Const.calendarDayFontSize,
                  color: date.month == _calendarController.focusedDay.month
                      ? Const.calendarTextColor
                      : Const.calendarOutsideDayBackgroundColor,
                ),
              ),
            ),
          );
        },
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                color: Const.calendarSelectedBackgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Const.calendarDayFontSize,
                    color: Const.calendarSelectedDayTextColor,
                  ),
                ),
                // ),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              color: date.month == _calendarController.focusedDay.month
                  ? Const.calendarTodayBackgroundColor
                  : Const.calendarOutsideTodayBackgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text('${date.day}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Const.calendarDayFontSize,
                    color: Const.calendarTodayTextColor,
                  )),
            ),
          );
        },
        weekendDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: Const.calendarDayFontSize,
                  color: Const.calendarWeekendBackgroundColor,
                ),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Align(
                alignment: Const.calendarMarkerAlignment,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: events
                      .take(3)
                      .map((event) => _buildEventsMarker(date))
                      .toList(),
                ),
              ),
            );
          }

          return children;
        },
      ),
      calendarController: _calendarController,
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: (first, last, format) {
        _onVisibleDaysChanged(first, last, format);
      },
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date) {
    return Container(
      width: 6.5,
      height: 6.5,
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: date.month == _calendarController.focusedDay.month
            ? Const.calendarMarkerColor
            : Const.calendarOutsideMarkerColor,
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: _selectedEvents
          .map((event) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Item(
                  child: ListTile(
                    title: Text(event.toString()),
                    onTap: () => print('$event tapped!'),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
