import 'package:app_qldt/_models/event.dart';
import 'package:app_qldt/app/app.dart';
import 'package:app_qldt/calendar/view/local_widgets/calendar_header_builder.dart';
import 'package:app_qldt/calendar/view/local_widgets/days_of_week_builder.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:table_calendar/table_calendar.dart';

import 'package:app_qldt/_authentication/authentication.dart';
import 'package:app_qldt/calendar/bloc/calendar_bloc.dart';
import 'package:app_qldt/calendar/view/local_widgets/outside_weekend_day_builder.dart';

import 'package:app_qldt/calendar/view/local_widgets/local_widgets.dart';

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
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final schedulesData = UserDataModel.of(context)!.localScheduleService.eventsData;

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return FutureBuilder(
          builder: (_, AsyncSnapshot<Map<DateTime, List<dynamic>>> snapshot) {
            return BlocProvider(
              create: (_) {
                return CalendarBloc();
              },
              child: Container(
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
                        DaysOfWeekBuilder(),
                        CalendarHeaderBuilder(calendarController: _calendarController),
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<CalendarBloc, CalendarState>(
                        buildWhen: (_, current) => current.buildFirstTime,
                        builder: (_, state) {
                          return _EventList(event: state.selectedEvents);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    _BottomNote(calendarController: _calendarController),
                  ],
                ),
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

class _EventList extends StatelessWidget {
  final List? event;

  const _EventList({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event == null || event!.length == 0) {
      return Container(color: Colors.transparent);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: ScrollConfiguration(
        behavior: _EventListScrollBehavior(),
        child: ListView.separated(
          padding: const EdgeInsets.only(),
          itemCount: min(event!.length, 3),
          separatorBuilder: (_, __) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: Color(0xff694A85),
                indent: 45,
                endIndent: 45,
                thickness: 2,
              ),
            );
          },
          itemBuilder: (_, index) => _EventListItem(event: event![index]),
        ),
      ),
    );
  }
}

class _EventListScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(_, Widget child, __) {
    return child;
  }
}

class _EventListItem extends StatelessWidget {
  final UserEvent event;

  const _EventListItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String minute = '0' + event.time.minute.toString();
    minute = minute.substring(minute.length - 2);

    String hour = event.time.hour.toString();

    return Container(
      child: Row(
        children: <Widget>[
          Text(
            hour + ':' + minute,
            style: TextStyle(
              color: Color(0xff694A85),
              fontSize: 25,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                event.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff694A85),
                ),
              ),
              Text(
                event.location ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff694A85),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BottomNote extends StatelessWidget {
  final CalendarController calendarController;

  const _BottomNote({
    Key? key,
    required this.calendarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Stack(
        children: <Widget>[
          _BottomText(),
          _AddNoteButton(),
        ],
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff26153B),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Bạn có dự định gì không?',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff85749C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: Color(0xff694A85),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Align(
          alignment: Alignment(-0.7, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 16,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                'Thêm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
