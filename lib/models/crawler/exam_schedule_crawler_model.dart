class ExamScheduleCrawlerModel {
  final String idStudent;
  final int idAccount;
  final bool all;

  ExamScheduleCrawlerModel({
    required this.idStudent,
    required this.idAccount,
    this.all = false,
  });


  Map<String, String> toJson() => {
    'id_student': idStudent,
    'id_account': idAccount as String,
    'all': all.toString(),
  };

  @override
  String toString() {
    return 'id: $idStudent, qldt_password: $idAccount';
  }
}