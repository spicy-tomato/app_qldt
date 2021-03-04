part of 'screen_bloc.dart';

abstract class ScreenEvent extends Equatable {
  const ScreenEvent();

  @override
  List<Object> get props => [];
}

class ScreenPageChanged extends ScreenEvent {
  final ScreenPage screenPage;

  ScreenPageChanged(this.screenPage);

  @override
  List<Object> get props => [];
}
