import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:app_qldt/_repositories/authentication_repository/authentication_repository.dart';
import 'package:app_qldt/_repositories/user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription =
        _authenticationRepository.stream.listen((status) => add(AuthenticationStatusChanged(status)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      yield* _mapAuthenticationLogoutRequestedToState();
    }
  }

  @override
  Future<void> close() async {
    await _authenticationStatusSubscription.cancel();
    await _authenticationRepository.dispose();
    await super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    final user = await _tryGetUser();

    if (user != null) {
      return AuthenticationState.authenticated(user);
    }

    if (event.status == AuthenticationStatus.unauthenticated) {
      return const AuthenticationState.unauthenticated();
    }

    return const AuthenticationState.unknown();
  }

  Stream<AuthenticationState> _mapAuthenticationLogoutRequestedToState() async* {
    yield const AuthenticationState.unknown();
    await _authenticationRepository.logOut();
    await Future.delayed(const Duration(seconds: 2));
    yield const AuthenticationState.unauthenticated();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
