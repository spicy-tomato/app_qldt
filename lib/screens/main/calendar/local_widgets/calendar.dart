import 'package:app_qldt/blocs/calendar/calendar_bloc.dart';
import 'package:app_qldt/blocs/plan/plan_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:app_qldt/models/event/user_event_model.dart';

import 'calendar_widgets/calendar_widgets.dart';

extension DateTimeExtexsion on DateTime {
  DateTime get toStandard => DateTime(year, month, day);

  bool isBetween(DateTime before, DateTime after) {
    return isAfter(before) && isBefore(after);
  }

  bool isTheSameMonth(DateTime dateTime) {
    return month == dateTime.month;
  }
}


class Calendar<UserEvent> extends StatefulWidget {
  final Map<DateTime, List<UserEvent?>> events;

  const Calendar({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar<UserEventModel>> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late final PageController _pageController;

  DateTime _focusedDay = DateTime.now().toStandard;
  late DateTime _selectedDay;
  final DateTime firstDay = DateTime(2020, 7, 31);
  final DateTime lastDay = DateTime(2024, 7, 31);

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (_, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: _focusedDay,
            locale: 'vi_VI',
            eventLoader: _eventLoader,
            weekendDays: const [DateTime.sunday],
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {CalendarFormat.month: ''},
            headerVisible: true,
            headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextFormatter: _titleTextFormatter,
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            daysOfWeekHeight: 20,
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: _dowTextFormatter,
              weekdayStyle: const TextStyle(
                color: Colors.white,
              ),
              weekendStyle: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            calendarStyle: const CalendarStyle(
              cellMargin: EdgeInsets.all(2),
            ),
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (_, date, __) {
                return OutsideDayWidget(date: date);
              },
              defaultBuilder: (_, date, __) {
                return DayWidget(date: date);
              },
              selectedBuilder: (_, date, __) {
                return SelectedDayWidget(date, _animationController);
              },
              todayBuilder: (_, date, __) {
                return date.isTheSameMonth(_focusedDay)
                    ? TodayInFocusedMonthWidget(date: date)
                    : TodayOutFocusedMonthWidget(date: date);
              },
              markerBuilder: (_, day, List<UserEventModel> events) {
                return day.month == _focusedDay.month
                    ? DayInFocusMonthMarker(events)
                    : DayOutFocusedMonthMarker(events);
              },
            ),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onCalendarCreated: _onCalendarCreated,
            onDaySelected: (selectedDay, focusedDay) {
              _onDaySelected(selectedDay, focusedDay);
              _animationController.forward(from: 0.0);
            },
            onPageChanged: _onPageChanged,
          ),
        );
      },
    );
  }

  List<UserEventModel?> _eventLoader(DateTime day) {
    day = day.toStandard;
    return widget.events[day] == null ? [] : widget.events[day]!;
  }

  String _dowTextFormatter(DateTime date, dynamic locale) {
    String s = DateFormat.E(locale).format(date);
    if (s[0] == 'T') {
      s = s[0] + s[3];
    }

    return s;
  }

  String _titleTextFormatter(DateTime date, dynamic locale) {
    String s = DateFormat.yMMMM(locale).format(_focusedDay);
    return s[0].toUpperCase() + s.substring(1);
  }

  void _onCalendarCreated(PageController pageController) {
    _pageController = pageController;
    context.read<CalendarBloc>().add(CalendarDaySelected(_focusedDay, widget.events[_focusedDay] ?? []));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    context.read<PlanBloc>().add(PlanFromDateChanged(focusedDay));
    context.read<PlanBloc>().add(PlanToDateChanged(focusedDay.add(const Duration(hours: 1))));

    if (!isSameDay(_selectedDay, selectedDay)) {
      selectedDay = selectedDay.toStandard;

      context.read<CalendarBloc>().add(CalendarDaySelected(selectedDay, _eventLoader(selectedDay)));

      if (selectedDay.month != focusedDay.month && selectedDay.isBefore(focusedDay)) {
        _selectedDay = selectedDay;

        await _pageController.previousPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

        setState(() {
          _focusedDay = focusedDay.subtract(const Duration(days: 1));
        });
      } else if (selectedDay.month != focusedDay.month && selectedDay.isAfter(focusedDay)) {
        _selectedDay = selectedDay;

        await _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

        setState(() {
          _focusedDay = focusedDay.add(const Duration(days: 1));
        });
      } else {
        setState(() {
          _focusedDay = focusedDay;
          _selectedDay = selectedDay;
        });
      }
    }
  }

  _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }
}
