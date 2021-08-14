import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modify_range_event.dart';
part 'modify_range_state.dart';

class ModifyRangeBloc extends Bloc<ModifyRangeEvent, ModifyRangeState> {
  ModifyRangeBloc() : super(const ModifyRangeInitial());

  @override
  Stream<ModifyRangeState> mapEventToState(
    ModifyRangeEvent event,
  ) async* {
    if (event is ModifyRangeChanged){
      yield _mapModifyRangeChangedToState(event);
    }
  }

  ModifyRangeState _mapModifyRangeChangedToState(ModifyRangeChanged event) {
    return ModifyRangeState(event.range);
  }
}
