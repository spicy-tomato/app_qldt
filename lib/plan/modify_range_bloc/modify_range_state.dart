part of 'modify_range_bloc.dart';

enum ModifyRange {
  thisEvent,
  all,
}

extension ModifyRangeExtension on ModifyRange {
  static String stringFunction(ModifyRange range) {
    return range.string;
  }

  String get string {
    if (this == ModifyRange.thisEvent) {
      return 'Chỉ sự kiện này';
    } else {
      return 'Tất cả các sự kiện';
    }
  }

  bool get isAllEvent => this == ModifyRange.all;
}

class ModifyRangeState extends Equatable {
  final ModifyRange range;

  const ModifyRangeState(this.range);

  @override
  List<Object> get props => [range];
}

class ModifyRangeInitial extends ModifyRangeState {
  ModifyRangeInitial() : super(ModifyRange.thisEvent);
}
