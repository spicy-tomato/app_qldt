class ExamScheduleCrawler {
  final String idStudent;
  final String idAccount;

  ExamScheduleCrawler({
    required this.idStudent,
    required this.idAccount,
  });


  Map<String, String> toJson() => {
    'id_student': idStudent,
    'id_account': idAccount,
  };

  @override
  String toString() {
    return 'id: $idStudent, qldt_password: $idAccount';
  }
}