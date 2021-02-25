import 'package:app_qldt/services/tokenService.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:app_qldt/widgets/interface.dart';
import 'package:app_qldt/widgets/item.dart';
import 'package:app_qldt/utils/const.dart';
import 'package:app_qldt/services/calendarService.dart';
import 'package:firebase_repository/firebase_repository.dart';

bool dateIsBetween(DateTime date, DateTime before, DateTime after) {
  return date.isAfter(before) && date.isBefore(after);
}

class Calendar extends StatefulWidget {
  Calendar({
    Key key,
    @required this.studentId,
    @required this.firebaseRepository,
  }) : super(key: key);

  final String studentId;
  final FirebaseRepository firebaseRepository;

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

    _selectedEvents = new List();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();

    _lastSelectedDay = DateTime.now();

    upsertToken(widget.firebaseRepository, widget.studentId);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getList(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<DateTime, List>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        _events = snapshot.data;
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
      },
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      locale: 'vi_VI',
      events: _events,
      // holidays: _holidays,
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
        // _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: (first, last, format) {
        _onVisibleDaysChanged(first, last, format);
      },
      onCalendarCreated: _onCalendarCreated,
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('On day selected');

    setState(() {
      _selectedEvents = events;
      _lastSelectedDay = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('----------------------------');
    // print('On visible day changed');

    if (dateIsBetween(_lastSelectedDay, first, last)) {
      print('Date is between');
      DateTime _dayWillBeSelected =
          _lastSelectedDay.month == _calendarController.focusedDay.month
              ? _lastSelectedDay
              : DateTime(_calendarController.focusedDay.year,
                  _calendarController.focusedDay.month, 1);

      // print('Day will be selected: $_dayWillBeSelected');
      // print('Selected day: ${_calendarController.selectedDay}');

      setState(() {
        _calendarController.setSelectedDay(_dayWillBeSelected);
        _selectedEvents = _events[toStandard(_dayWillBeSelected)] ?? [];
        print('Selected events: $_selectedEvents');
      });
    } else {
      print('Date is not between');
      DateTime _dayWillBeSelected = _calendarController.focusedDay;

      // print('Day will be selected: $_dayWillBeSelected');
      // print('Selected day: ${_calendarController.selectedDay}');

      setState(() {
        _calendarController.setSelectedDay(_dayWillBeSelected);
        _selectedEvents = _events[toStandard(_dayWillBeSelected)] ?? [];
        print('Selected events: $_selectedEvents');
      });
    }
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

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
          .toList(),
    );
  }

  Future<Map<DateTime, List>> getList() {
    return getData(widget.studentId);
  }

  DateTime toStandard(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }
}
