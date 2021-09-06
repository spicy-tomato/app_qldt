part of 'local_widgets.dart';

class Schedule extends StatefulWidget {
  final UserDataSourceModel dataSource;
  final CalendarController controller;

  const Schedule(
    this.dataSource, {
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late DateTime? _previousSelectedDay;
  late CalendarView? _prevView;
  late AppThemeModel themeData;
  late TimeSlotViewSettings _timeSlotViewSettings;
  late ScheduleViewSettings _scheduleViewSettings;
  late MonthViewSettings _monthViewSettings;
  late ViewHeaderStyle _viewHeaderStyle;
  late CalendarHeaderStyle _headerStyle;
  late TextStyle _appointmentTextStyle;

  final _allowViews = [
    CalendarView.schedule,
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.view = CalendarView.week;
    themeData = context.read<AppSettingBloc>().state.theme.data;

    _timeSlotViewSettings = TimeSlotViewSettings(
      timeInterval: const Duration(hours: 1),
      timeFormat: 'H:mm',
      timeIntervalHeight: 35,
      timeTextStyle: TextStyle(
        color: themeData.secondaryTextColor,
        fontSize: 12,
      ),
    );

    _scheduleViewSettings = const ScheduleViewSettings(
      weekHeaderSettings: WeekHeaderSettings(
        startDateFormat: 'd MMMM ',
        endDateFormat: 'd MMMM',
      ),
    );

    _monthViewSettings = const MonthViewSettings(
      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
    );

    _viewHeaderStyle = ViewHeaderStyle(
      dateTextStyle: TextStyle(
        color: themeData.secondaryTextColor,
      ),
      dayTextStyle: TextStyle(
        color: themeData.secondaryTextColor,
      ),
    );

    _headerStyle = CalendarHeaderStyle(
      textStyle: TextStyle(
        color: themeData.secondaryTextColor,
        fontFamily: AppConstant.fontFamily,
        fontSize: 18,
      ),
    );

    _appointmentTextStyle = const TextStyle(fontSize: 12);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        return SfCalendar(
          cellBorderColor: themeData.bottomNoteSecondaryColor,
          selectionBorderColor: themeData.secondaryTextColor,
          todayHighlightColor: themeData.primaryColor,
          headerStyle: _headerStyle,
          viewHeaderStyle: _viewHeaderStyle,
          monthViewSettings: _monthViewSettings,
          scheduleViewSettings: _scheduleViewSettings,
          timeSlotViewSettings: _timeSlotViewSettings,
          appointmentTextStyle: _appointmentTextStyle,
          controller: widget.controller,
          dataSource: widget.dataSource,
          allowedViews: _allowViews,
          scheduleViewMonthHeaderBuilder: _scheduleViewMonthHeaderBuilder,
          showNavigationArrow: false,
          showDatePickerButton: true,
          allowViewNavigation: true,
          showCurrentTimeIndicator: true,
          view: CalendarView.week,
          minDate: DateTime(2020, 8, 1),
          maxDate: DateTime(2024, 8, 31),
          firstDayOfWeek: 1,
          onTap: (details) => _onTap(details, state),
          initialDisplayDate: DateTime.now(),
          onViewChanged: (_) => _onViewChanged(),
        );
      },
    );
  }

  Future<void> _onTap(CalendarTapDetails details, PlanState state) async {
    if (_prevView == CalendarView.month) {
      widget.controller.selectedDate = null;
      return;
    }

    if (details.targetElement == CalendarElement.calendarCell) {
      if (state.visibility.isClosed) {
        context.read<PlanBloc>().add(ShowApartPlanPage(details.date!));
      } else if (_previousSelectedDay != null && details.date == _previousSelectedDay) {
        widget.controller.selectedDate = null;
        context.read<PlanBloc>().add(const OpenPlanPage());
      } else if (_previousSelectedDay != null && details.date != _previousSelectedDay) {
        widget.controller.selectedDate = null;
        context.read<PlanBloc>().add(ClosePlanPage());
      }

      _previousSelectedDay = details.date!;
    } else if (details.targetElement == CalendarElement.appointment) {
      if (!state.visibility.isClosed) {
        context.read<PlanBloc>().add(ClosePlanPage());
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => EventInfoPage(context, event: details.appointments![0])));
      }

      widget.controller.selectedDate = null;
    } else {
      if (!state.visibility.isClosed) {
        context.read<PlanBloc>().add(ClosePlanPage());
      }
    }
  }

  void _onViewChanged() {
    _prevView = widget.controller.view;
  }

  Widget _scheduleViewMonthHeaderBuilder(_, details) {
    final String monthName = 'Tháng ${details.date.month}';
    return Stack(
      children: <Widget>[
        Image(
          image: ExactAssetImage(AppConstant.asset.scheduleDesign),
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
            '$monthName ${details.date.year.toString()}',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
