import 'package:app_qldt/_models/account_permission_enum.dart';

class LoginUser {
  final String id;
  final String password;
  final AccountPermission accountPermission;

  const LoginUser(this.id, this.password, this.accountPermission);

  Map<String, String> toJson() => {
        'username': id,
        'password': password,
      };
}
