part of 'plan_bloc.dart';

enum PlanAccessibility { defaultAccess, private, public }

enum PlanStatus { free, busy }

enum PlanRepeat { noRepeat, daily, weekly, monthly, yearly, custom }

extension PlanRepeatExtension on PlanRepeat {
  String get string {
    switch (this){
      case PlanRepeat.noRepeat:
        return 'Không lặp lại';

      case PlanRepeat.daily:
        return 'Hàng ngày';

      case PlanRepeat.weekly:
        return 'Hàng tuần';

      case PlanRepeat.monthly:
        return 'Hàng tháng';

      case PlanRepeat.yearly:
        return 'Hàng năm';

      default:
        return 'Tuỳ chỉnh...';
    }
  }
}

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
        status
      ];
}
