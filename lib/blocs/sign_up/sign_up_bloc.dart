import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:app_qldt/enums/config/screen.dart';
import 'package:app_qldt/enums/http/http_status.dart';
import 'package:app_qldt/models/form/form.dart';
import 'package:app_qldt/models/sign_up/sign_up_user.dart';
import 'package:app_qldt/services/api/sign_up_service.dart';
import 'package:app_qldt/widgets/wrapper/app_mode.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final BuildContext context;

  SignUpBloc(this.context) : super(const SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpUsernameChanged) {
      yield _mapUsernameChangedToState(event);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmitToState();
    } else if (event is SignUpPasswordVisibleChanged) {
      yield _mapSignUpPasswordVisibleChangedToState(event);
    } else if (event is ShowedSignUpFailedDialog) {
      yield _mapShowedSignUpFailedDialogToState();
    }
  }

  SignUpState _mapUsernameChangedToState(SignUpUsernameChanged event) {
    final username = UsernameModel.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  SignUpState _mapPasswordChangedToState(SignUpPasswordChanged event) {
    final password = PasswordModel.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmitToState() async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        final apiUrl = AppModeWidget.of(context).apiUrl;
        final loginUser = SignUpUser(state.username.value, state.password.value);

        final loginStatus = (await SignUpService(apiUrl).signUp(loginUser)).status;

        if (loginStatus.isSuccessfully) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
          await Navigator.of(context).pushNamedAndRemoveUntil(ScreenPage.enterInformation.string, (_) => false);
        } else {
          yield state.copyWith(
            status: FormzStatus.submissionFailure,
            shouldShowSignUpFailedDialog: true,
          );
        }
      } on Exception catch (_) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          shouldShowSignUpFailedDialog: true,
        );
      }
    } else {
      yield state.copyWith(
        status: FormzStatus.invalid,
        username: UsernameModel.dirty(state.username.value),
        password: PasswordModel.dirty(state.password.value),
      );
    }
  }

  SignUpState _mapSignUpPasswordVisibleChangedToState(SignUpPasswordVisibleChanged event) {
    return state.copyWith(hidePassword: event.hidePassword ?? !state.hidePassword);
  }

  SignUpState _mapShowedSignUpFailedDialogToState() {
    return state.copyWith(shouldShowSignUpFailedDialog: false);
  }
}
