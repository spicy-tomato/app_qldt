part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  const SignUpUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpPasswordVisibleChanged extends SignUpEvent {
  final bool? hidePassword;

  const SignUpPasswordVisibleChanged([this.hidePassword]);

  @override
  List<Object> get props => [hidePassword!];
}

class SignUpSubmitted extends SignUpEvent {}

class ShowedSignUpFailedDialog extends SignUpEvent {}
