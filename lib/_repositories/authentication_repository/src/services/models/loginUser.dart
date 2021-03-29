class LoginUser {
  final String id;
  final String password;

  const LoginUser(this.id, this.password);

  Map<String, String> toJson() => {
        'ID_Student': id,
        'Password': password,
      };
}
