class Gpa {
  final String semester;
  final double gpa10;
  final double gpa4;

  Gpa({
    required this.semester,
    required this.gpa10,
    required this.gpa4,
  });

  List<dynamic> toList() {
    return [
      gpa10,
      gpa4,
    ];
  }
}
