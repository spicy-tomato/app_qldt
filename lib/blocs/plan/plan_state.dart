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
  final PlanType type;
  final int? id;

  const PlanState({
    this.title = '',
    this.isAllDay = false,
    required this.fromDay,
    required this.toDay,
    this.type = PlanType.create,
    this.repeat = PlanRepeat.noRepeat,
    this.people = '',
    this.location = '',
    this.description = '',
    this.accessibility = PlanAccessibility.defaultAccess,
    this.status = PlanStatus.free,
    this.color = PlanColors.defaultColor,
    this.visibility = PlanPageVisibility.close,
    this.id,
  });

  PlanState copyWith({
    String? title,
    bool? isAllDay,
    DateTime? from,
    DateTime? to,
    PlanType? type,
    PlanRepeat? repeat,
    String? people,
    String? location,
    String? description,
    PlanAccessibility? accessibility,
    PlanStatus? status,
    PlanColors? color,
    PlanPageVisibility? visibility,
    int? id,
  }) {
    return PlanState(
      title: title ?? this.title,
      isAllDay: isAllDay ?? this.isAllDay,
      fromDay: from ?? fromDay,
      toDay: to ?? toDay,
      type: type ?? this.type,
      repeat: repeat ?? this.repeat,
      people: people ?? this.people,
      location: location ?? this.location,
      description: description ?? this.description,
      accessibility: accessibility ?? this.accessibility,
      status: status ?? this.status,
      color: color ?? this.color,
      visibility: visibility ?? this.visibility,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        title,
        isAllDay,
        fromDay,
        toDay,
        type,
        repeat,
        people,
        location,
        description,
        accessibility,
        status,
        color,
        visibility,
        id,
      ];
}
