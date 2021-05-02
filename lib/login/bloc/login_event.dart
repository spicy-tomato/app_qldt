part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class HideLoginDialog extends LoginEvent {
  final bool hide;

  const HideLoginDialog(this.hide);

  @override
  List<Object> get props => [hide];
}

class HideKeyboard extends LoginEvent {
  final bool hide;

  const HideKeyboard(this.hide);

  @override
  List<Object> get props => [hide];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  const LoginUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordVisibleChanged extends LoginEvent {
  const PasswordVisibleChanged();
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
