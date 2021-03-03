import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

void main() {
  runApp(Application(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
