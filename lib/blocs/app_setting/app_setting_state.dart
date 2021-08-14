part of 'app_setting_bloc.dart';

class AppSettingState extends Equatable {
  final AppTheme theme;
  final AppLocale locale;

  const AppSettingState({
    required this.theme,
    required this.locale,
  });

  AppSettingState copyWith({
    AppTheme? theme,
    AppLocale? locale,
  }) {
    return AppSettingState(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        theme,
        locale,
      ];
}

class AppSettingInitial extends AppSettingState {
  const AppSettingInitial()
      : super(
          theme: AppTheme.dream,
          locale: AppLocale.vietnamese,
        );
}
