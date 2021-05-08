part of 'plan_bloc.dart';

class PlanState extends Equatable {
  final String title;
  final bool isAllDay;
  final DateTime fromDay;
  final DateTime toDay;
  final PlanRepeat repeat;
  final String people;
  final String location;
  final String description;
  final PlanAccessibility accessibility;
  final PlanStatus status;
  final PlanColors color;
  final PlanPageVisibility visibility;

  const PlanState({
    this.title = '',
    this.isAllDay = false,
    required this.fromDay,
    required this.toDay,
    this.repeat = PlanRepeat.noRepeat,
    this.people = '',
    this.location = '',
    this.description = '',
    this.accessibility = PlanAccessibility.defaultAccess,
    this.status = PlanStatus.free,
    this.color = PlanColors.defaultColor,
    this.visibility = PlanPageVisibility.close,
  });

  PlanState copyWith({
    String? title,
    bool? isAllDay,
    DateTime? from,
    DateTime? to,
    PlanRepeat? repeat,
    String? people,
    String? location,
    String? description,
    PlanAccessibility? accessibility,
    PlanStatus? status,
    PlanColors? color,
    PlanPageVisibility? visibility,
  }) {
    return PlanState(
      title: title ?? this.title,
      isAllDay: isAllDay ?? this.isAllDay,
      fromDay: from ?? this.fromDay,
      toDay: to ?? this.toDay,
      repeat: repeat ?? this.repeat,
      people: people ?? this.people,
      location: location ?? this.location,
      description: description ?? this.description,
      accessibility: accessibility ?? this.accessibility,
      status: status ?? this.status,
      color: color ?? this.color,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  List<Object?> get props => [
        title,
        isAllDay,
        fromDay,
        toDay,
        repeat,
        people,
        location,
        description,
        accessibility,
        status,
        color,
        visibility,
      ];
}
