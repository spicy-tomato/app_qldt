part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  final DateTime? visibleDay;
  final List? selectedEvents;
  final DateTime? lastSelectedDay;
  final List? lastSelectedDayEvents;
  final bool buildFirstTime;

  const CalendarState._(this.buildFirstTime,
      {this.visibleDay,
      this.selectedEvents,
      this.lastSelectedDay,
      this.lastSelectedDayEvents});

  const CalendarState.init(DateTime today, List todayEvents)
      : this._(
          true,
          visibleDay: today,
          selectedEvents: todayEvents,
          lastSelectedDay: today,
          lastSelectedDayEvents: todayEvents,
        );

  const CalendarState.unknown() : this._(true);

  CalendarState copyWith(
    bool buildFirstTime, {
    DateTime? visibleDay,
    List? selectedEvents,
    DateTime? lastSelectedDay,
    List? lastSelectedDayEvents,
  }) {
    return CalendarState._(
      buildFirstTime,
      visibleDay: visibleDay ?? this.visibleDay,
      selectedEvents: selectedEvents ?? this.selectedEvents,
      lastSelectedDay: lastSelectedDay ?? this.lastSelectedDay,
      lastSelectedDayEvents:
          lastSelectedDayEvents ?? this.lastSelectedDayEvents,
    );
  }

  @override
  List<Object> get props => [
        buildFirstTime,
        visibleDay ?? DateTime.now(),
        selectedEvents ?? [],
        lastSelectedDay ?? DateTime.now(),
        lastSelectedDayEvents ?? [],
      ];
}
