import 'package:app_qldt/_models/meeting_data_source.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Schedule extends StatefulWidget {
  final UserDataSource dataSource;

  const Schedule(
    this.dataSource, {
    Key? key,
  }) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late CalendarController _controller = CalendarController();

  @override
  void initState() {
    _controller.view = CalendarView.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        controller: _controller,
        dataSource: widget.dataSource,
        allowedViews: [
          CalendarView.day,
          CalendarView.week,
          CalendarView.schedule,
        ],
        scheduleViewMonthHeaderBuilder: _scheduleViewBuilder,
        showNavigationArrow: false,
        showDatePickerButton: true,
        allowViewNavigation: true,
        showCurrentTimeIndicator: true,
        view: CalendarView.week,
        minDate: DateTime(2020, 8, 1),
        maxDate: DateTime(2024, 8, 31),
        firstDayOfWeek: 1,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(hours: 1),
          timeFormat: 'H:mm',
          timeIntervalHeight: 30,
        ),
        initialDisplayDate: DateTime.now(),
        onTap: _calendarTapped,
        // onViewChanged: _onViewChanged,
      ),
    );
  }

  void _calendarTapped(CalendarTapDetails calendarTapDetails) {}

  Widget _scheduleViewBuilder(_, details) {
    final String monthName = "Tháng ${details.date.month}";
    return Stack(
      children: [
        Image(
          image: ExactAssetImage('images/' + monthName + '.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height,
        ),
        Positioned(
          left: 55,
          right: 0,
          top: 20,
          bottom: 0,
          child: Text(
            monthName + ' ' + details.date.year.toString(),
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
