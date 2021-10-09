class SignUpUser {
  final String id;
  final String password;

  const SignUpUser(this.id, this.password);

  Map<String, String> toJson() => {
    'username': id,
    'password': password,
  };
}
