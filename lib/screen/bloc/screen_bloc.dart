import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tab_repository/tab_repository.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  final ScreenRepository _screenRepository;

  ScreenBloc({@required ScreenRepository screenRepository})
      : assert(screenRepository != null),
        _screenRepository = screenRepository,
        super(ScreenState.defaultPage());

  @override
  Stream<ScreenState> mapEventToState(
    ScreenEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
