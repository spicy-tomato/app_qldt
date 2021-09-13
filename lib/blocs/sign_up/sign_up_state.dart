part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final FormzStatus status;
  final UsernameModel username;
  final PasswordModel password;
  final bool hidePassword;
  final bool hideKeyboard;
  final bool hideSignUpDialog;
  final bool shouldShowSignUpFailedDialog;

  const SignUpState({
    required this.status,
    required this.username,
    required this.password,
    required this.hidePassword,
    required this.hideKeyboard,
    required this.hideSignUpDialog,
    required this.shouldShowSignUpFailedDialog,
  });

  SignUpState copyWith({
    FormzStatus? status,
    UsernameModel? username,
    PasswordModel? password,
    bool? hidePassword,
    bool? hideKeyboard,
    bool? hideSignUpDialog,
    bool? shouldShowSignUpFailedDialog,
  }) {
    return SignUpState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
      hideKeyboard: hideKeyboard ?? this.hideKeyboard,
      hideSignUpDialog: hideSignUpDialog ?? this.hideSignUpDialog,
      shouldShowSignUpFailedDialog: shouldShowSignUpFailedDialog ?? this.shouldShowSignUpFailedDialog,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        hidePassword,
        hideKeyboard,
        hideSignUpDialog,
        shouldShowSignUpFailedDialog,
      ];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial()
      : super(
          status: FormzStatus.pure,
          username: const UsernameModel.pure(),
          password: const PasswordModel.pure(),
          hidePassword: true,
          hideKeyboard: true,
          hideSignUpDialog: true,
          shouldShowSignUpFailedDialog: true,
        );
}
