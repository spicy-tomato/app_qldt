class Semester {
  final String semester;

  const Semester([String? semester]) : this.semester = semester == null ? '' : semester;

  static Semester get all => Semester();

  static String getString(Semester semester) => semester.toString();

  String get query => _string;

  @override
  bool operator ==(Object other) {
    return other is Semester && semester == other.semester;
  }

  @override
  int get hashCode => semester.hashCode;

  @override
  String toString() => semester == '' ? 'Tất cả' : semester;
}
