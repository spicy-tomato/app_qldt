import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:user_repository/user_repository.dart';

import 'loginApp.dart';

void main() {
  runApp(LoginApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
