part of 'screen_bloc.dart';

class ScreenState extends Equatable {
  final ScreenPage screenPage;

  const ScreenState._({
    this.screenPage = ScreenPage.home,
  });

  const ScreenState.defaultPage() : this._();

  const ScreenState.home() : this._();

  const ScreenState.notification()
      : this._(screenPage: ScreenPage.notification);

  @override
  List<Object> get props => [screenPage];
}
