part of 'app_setting_bloc.dart';

abstract class AppSettingEvent extends Equatable {
  const AppSettingEvent();
}

class ThemeChanged extends AppSettingEvent {
  final AppTheme theme;

  const ThemeChanged(this.theme);

  @override
  List<Object?> get props => [theme];
}
