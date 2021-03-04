part of 'sidebar_bloc.dart';

abstract class ScreenEvent extends Equatable {
  const ScreenEvent();

  @override
  List<Object> get props => [];
}

class ScreenPageChange extends ScreenEvent {
  final ScreenPage screenPage;

  ScreenPageChange(this.screenPage);

  @override
  List<Object> get props => [screenPage];
}