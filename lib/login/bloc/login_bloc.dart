import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import 'package:app_qldt/_repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/login/models/models.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is HideLoginDialog) {
      yield _mapLoginDialogVisibleChangedToState(event);
    } else if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmitToState();
    } else if (event is LoginPasswordVisibleChanged) {
      yield _mapLoginPasswordVisibleChangedToState();
    } else if (event is ShowedLoginFailedDialog) {
      yield _mapShowedLoginFailedDialogToState();
    }
  }

  LoginState _mapLoginDialogVisibleChangedToState(HideLoginDialog event) {
    return state.copyWith(hideLoginDialog: event.hide);
  }

  LoginState _mapUsernameChangedToState(LoginUsernameChanged event) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(LoginPasswordChanged event) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    );
  }

  Stream<LoginState> _mapLoginSubmitToState() async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        bool shouldLogin = await _authenticationRepository.logIn(
          id: state.username.value,
          password: state.password.value,
        );

        if (shouldLogin) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            shouldShowLoginFailedDialog: true,
          );
        }
      } on Exception catch (_) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          shouldShowLoginFailedDialog: true,
        );
      }
    } else {
      yield state.copyWith(
        status: FormzStatus.invalid,
        username: Username.dirty(state.username.value),
      );
    }
  }

  LoginState _mapLoginPasswordVisibleChangedToState() {
    return state.copyWith(hidePassword: !state.hidePassword);
  }

  LoginState _mapShowedLoginFailedDialogToState() {
    return state.copyWith(shouldShowLoginFailedDialog: false);
  }
}
