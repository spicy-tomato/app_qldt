class UpdatePasswordCrawler {
  final String idStudent;
  final String idAccount;
  final String password;

  UpdatePasswordCrawler({
    required this.idStudent,
    required this.idAccount,
    required this.password,
  });

  Map<String, String> toJson() => {
    'id_student': idStudent,
    'id_account': idAccount,
    'qldt_password': password,
  };

  @override
  String toString() {
    return 'id_studetnt: $idStudent, id: $idAccount, qldt_password: $password';
  }
}
