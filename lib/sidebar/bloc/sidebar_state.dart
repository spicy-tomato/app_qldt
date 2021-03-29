part of 'sidebar_bloc.dart';

class ScreenState extends Equatable {
  final ScreenPage screenPage;

  // ignore: todo
  // TODO: Opening tab
  const ScreenState._({this.screenPage = ScreenPage.home});

  const ScreenState.home() : this._();

  const ScreenState.notification()
      : this._(screenPage: ScreenPage.notification);

  @override
  List<Object> get props => [screenPage];
}
