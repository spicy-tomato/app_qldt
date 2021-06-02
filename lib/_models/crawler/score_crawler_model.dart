class ScoreCrawlerModel {
  final String idStudent;
  final String idAccount;
  final bool all;

  ScoreCrawlerModel({
    required this.idStudent,
    required this.idAccount,
    this.all = false,
  });


  Map<String, String> toJson() => {
    'id_student': idStudent,
    'id_account': idAccount,
    'all': all.toString(),
  };

  @override
  String toString() {
    return 'id: $idStudent, qldt_password: $idAccount';
  }
}
