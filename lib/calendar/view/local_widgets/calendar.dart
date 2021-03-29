import 'package:app_qldt/calendar/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

import 'calendar_widgets/calendar_widgets.dart';

extension DateTimeExtexsion on DateTime {
  DateTime get toStandard => DateTime(this.year, this.month, this.day);

  bool isBetween(DateTime before, DateTime after) {
    return this.isAfter(before) && this.isBefore(after);
  }

  bool isTheSameMonth(DateTime dateTime) {
    return this.month == dateTime.month;
  }
}

class Calendar extends StatefulWidget {
  final Map<DateTime, List> events;
  final CalendarController calendarController;

  Calendar({
    Key? key,
    required this.events,
    required this.calendarController,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      buildWhen: (previous, current) {
        return previous.visibleDay != null && previous.visibleDay != current.visibleDay;
      },
      builder: (_, __) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: TableCalendar(
            locale: 'vi_VI',
            events: widget.events,
            weekendDays: [DateTime.sunday],
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.month,
            formatAnimation: FormatAnimation.slide,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            headerVisible: false,
            calendarStyle: CalendarStyle(
              contentPadding: EdgeInsets.symmetric(horizontal: 25),
              renderDaysOfWeek: false,
            ),
            builders: CalendarBuilders(
              outsideDayBuilder: (_, date, __) {
                return OutsideDayWidget(date: date);
              },
              dayBuilder: (_, date, __) {
                return DayWidget(date: date);
              },
              selectedDayBuilder: (_, date, __) {
                return SelectedDayWidget(date, _animationController);
              },
              todayDayBuilder: (_, date, __) {
                return date.isTheSameMonth(widget.calendarController.focusedDay)
                    ? TodayInNowVisibleWidget(date: date)
                    : TodayOutNowVisibleWidget(date: date);
              },
              weekendDayBuilder: (_, date, __) {
                return WeekendWidget(date: date);
              },
              outsideWeekendDayBuilder: (_, date, __) {
                return OutsideWeekendWidget(date: date);
              },
              markersBuilder: (_, date, events, __) {
                return date.month == widget.calendarController.focusedDay.month
                    ? dayInNowVisibleMonthMarker(date, events)
                    : dayOutNowVisibleMonthMarker(date, events);
              },
            ),
            calendarController: widget.calendarController,
            onCalendarCreated: _onCalendarCreated,
            onDaySelected: (date, events, holidays) {
              // _animationController.reverse();
              _onDaySelected(date, events, holidays);
              _animationController.forward(from: 0.0);
            },
            onVisibleDaysChanged: (first, last, format) {
              _onVisibleDaysChanged(first, last, format);
            },
          ),
        );
      },
    );
  }

  void _onCalendarCreated(_, __, ___) {
    DateTime today = DateTime.now().toStandard;
    context.read<CalendarBloc>().add(CalendarDaySelected(today, widget.events[today] ?? []));
  }

  void _onDaySelected(DateTime day, List events, _) {
    DateTime _selectedDay = day.toStandard;

    context.read<CalendarBloc>().add(CalendarDaySelected(_selectedDay, events));
    widget.calendarController.setSelectedDay(_selectedDay);
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, _) {
    DateTime _lastSelectedDay = context.read<CalendarBloc>().state.lastSelectedDay!;

    if (_lastSelectedDay.isBetween(first, last)) {
      DateTime _dayWillBeSelected =
      _lastSelectedDay.month == widget.calendarController.focusedDay.month
          ? _lastSelectedDay.toStandard
          : DateTime(widget.calendarController.focusedDay.year,
          widget.calendarController.focusedDay.month, 1);

      widget.calendarController.setSelectedDay(_dayWillBeSelected);

      context.read<CalendarBloc>().add(CalendarVisibleDayChanged(
          _dayWillBeSelected.toStandard, widget.events[_dayWillBeSelected.toStandard] ?? []));
    } else {
      DateTime _dayWillBeSelected = widget.calendarController.focusedDay.toStandard;

      context.read<CalendarBloc>().add(
          CalendarVisibleDayChanged(_dayWillBeSelected, widget.events[_dayWillBeSelected] ?? []));

      widget.calendarController.setSelectedDay(_dayWillBeSelected);
    }
  }
}
