import 'dart:async';
import 'dart:convert';

import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/form/form.dart';
import 'package:app_qldt/repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/repositories/authentication_repository/src/services/services.dart';
import 'package:app_qldt/widgets/wrapper/app_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final BuildContext context;

  LoginBloc(this.context)
      : _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context),
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
      yield _mapLoginPasswordVisibleChangedToState(event);
    } else if (event is ShowedLoginFailedDialog) {
      yield _mapShowedLoginFailedDialogToState();
    }
  }

  LoginState _mapLoginDialogVisibleChangedToState(HideLoginDialog event) {
    return state.copyWith(hideLoginDialog: event.hide);
  }

  LoginState _mapUsernameChangedToState(LoginUsernameChanged event) {
    final username = UsernameModel.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(LoginPasswordChanged event) {
    final password = PasswordModel.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    );
  }

  Stream<LoginState> _mapLoginSubmitToState() async* {
    yield state.copyWith(hidePassword: true);

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final apiUrl = AppModeWidget.of(context).apiUrl;
        final loginUser = LoginUser(state.username.value, md5.convert(utf8.encode(state.password.value)).toString());

        final HttpResponseStatus loginStatus = await _authenticationRepository.logIn(apiUrl, loginUser);

        if (loginStatus.isSuccessfully) {
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
        username: UsernameModel.dirty(state.username.value),
      );
    }
  }

  LoginState _mapLoginPasswordVisibleChangedToState(LoginPasswordVisibleChanged event) {
    return state.copyWith(hidePassword: event.hidePassword ?? !state.hidePassword);
  }

  LoginState _mapShowedLoginFailedDialogToState() {
    return state.copyWith(shouldShowLoginFailedDialog: false);
  }
}
