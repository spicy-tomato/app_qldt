part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;
  final bool hidePassword;
  final bool hideKeyboard;
  final bool hideLoginDialog;

  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.hidePassword = true,
    this.hideKeyboard = true,
    this.hideLoginDialog = true,
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? hidePassword,
    bool? hideKeyboard,
    bool? hideLoginDialog,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
      hideKeyboard: hideKeyboard ?? this.hideKeyboard,
      hideLoginDialog: hideLoginDialog ?? this.hideLoginDialog,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, hidePassword, hideKeyboard, hideLoginDialog];
}

class LoginInitial extends LoginState {
  const LoginInitial()
      : super(
          status: FormzStatus.pure,
          username: const Username.pure(),
          password: const Password.pure(),
          hidePassword: true,
          hideKeyboard: true,
          hideLoginDialog: true,
        );
}
