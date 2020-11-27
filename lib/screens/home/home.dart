import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:swipedetector/swipedetector.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Table Calendar Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _lastSelectedDay;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    final _selectedDay = DateTime.utc(now.year, now.month, now.day, 12, 0, 0, 0);

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
      duration: const Duration(milliseconds: 400),
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
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _lastSelectedDay = day;
    });
    print(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    if (dateIsBetween(_lastSelectedDay, first, last)) {
      print("inside");
      DateTime _dayWillBeSelected =
      _lastSelectedDay.month == _calendarController.focusedDay.month
          ? _lastSelectedDay
          : DateTime(_calendarController.focusedDay.year,
          _calendarController.focusedDay.month, 1);
      setState(() {
        _selectedEvents = _events[_dayWillBeSelected] ?? [];
        _calendarController.setSelectedDay(_dayWillBeSelected);
      });
      print(_dayWillBeSelected);
      print(_events[_dayWillBeSelected]);
    } else {
      print('outside');
      DateTime _dayWillBeSelected = format == CalendarFormat.month
          ? _calendarController.focusedDay
          : first;
      setState(() {
        _selectedEvents = _events[_dayWillBeSelected] ?? [];
        _calendarController.setSelectedDay(_dayWillBeSelected);
      });
      print(_dayWillBeSelected);
      print(_events[_dayWillBeSelected]);
    }
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SwipeDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTableCalendarWithBuilders(),
            const SizedBox(height: 8.0),
            Expanded(
              child: _buildEventList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
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
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(color: Colors.red),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Stack(
            children: <Widget>[
              Center(child: _buildDay(date)),
              Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(
                    fontSize: 16.0,
                    color: date.month == _calendarController.focusedDay.month
                        ? Colors.black
                        : Colors.blueGrey,
                  ),
                ),
              )
            ],
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
            ),
            width: 50,
            height: 50,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
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

  Widget _buildDay(DateTime date) {
    return AnimatedContainer(
      width: _calendarController.isSelected(date)
          ? _calendarController.focusedDay.month == date.month
          ? 50
          : 0
          : 0,
      height: _calendarController.isSelected(date)
          ? _calendarController.focusedDay.month == date.month
          ? 50
          : 0
          : 0,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}
