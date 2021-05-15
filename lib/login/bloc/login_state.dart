part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Username username;
  final Password password;
  final bool hidePassword;
  final bool hideKeyboard;
  final bool hideLoginDialog;
  final bool shouldShowLoginFailedDialog;

  const LoginState({
    required this.status,
    required this.username,
    required this.password,
    required this.hidePassword,
    required this.hideKeyboard,
    required this.hideLoginDialog,
    required this.shouldShowLoginFailedDialog,
  });

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? hidePassword,
    bool? hideKeyboard,
    bool? hideLoginDialog,
    bool? shouldShowLoginFailedDialog,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
      hideKeyboard: hideKeyboard ?? this.hideKeyboard,
      hideLoginDialog: hideLoginDialog ?? this.hideLoginDialog,
      shouldShowLoginFailedDialog: shouldShowLoginFailedDialog ?? this.shouldShowLoginFailedDialog,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        hidePassword,
        hideKeyboard,
        hideLoginDialog,
        shouldShowLoginFailedDialog,
      ];
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
          shouldShowLoginFailedDialog: true,
        );
}
