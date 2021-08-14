part of 'plan_enum.dart';

enum PlanRepeat {
  noRepeat,
  daily,
  weekly,
  monthly,
  yearly,
  custom,
}

extension PlanRepeatExtension on PlanRepeat {
  String get string {
    switch (this) {
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
