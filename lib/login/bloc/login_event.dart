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

class LoginPasswordVisibleChanged extends LoginEvent {
  final bool? hidePassword;

  const LoginPasswordVisibleChanged({this.hidePassword});

  @override
  List<Object> get props => [hidePassword!];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class ShowedLoginFailedDialog extends LoginEvent {
  const ShowedLoginFailedDialog();
}
