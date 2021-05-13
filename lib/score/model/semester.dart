class Semester {
  final String semester;

  const Semester([String? semester]) : this.semester = semester == null ? '' : semester;

  static Semester get all => Semester();

  @override
  bool operator ==(Object other) {
    return other is Semester && semester == other.semester;
  }

  @override
  int get hashCode => semester.hashCode;

  @override
  String toString() => semester == '' ? 'Tất cả' : semester;
}
