part of 'screen_bloc.dart';

class ScreenState extends Equatable {
  final ScreenPage screenPage;

  const ScreenState._({
    this.screenPage = ScreenPage.Home,
  });

  const ScreenState.defaultPage() : this._();

  const ScreenState.homePage() : this._();

  @override
  List<Object> get props => [screenPage];
}
