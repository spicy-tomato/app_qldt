part of 'modify_range_bloc.dart';

abstract class ModifyRangeEvent extends Equatable {
  const ModifyRangeEvent();

  @override
  List<Object> get props => [];
}

class ModifyRangeChanged extends ModifyRangeEvent {
  final ModifyRange range;

  const ModifyRangeChanged(this.range);

  @override
  List<Object> get props => [range];
}
