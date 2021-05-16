class Semester {
  final String _string;

  const Semester([String? semester]) : this._string = semester == null ? '' : semester;

  static Semester get all => Semester();

  static String getString(Semester semester) => semester.toString();

  String get query => _string;

  @override
  bool operator ==(Object other) {
    return other is Semester && _string == other._string;
  }

  @override
  int get hashCode => _string.hashCode;

  @override
  String toString() => _string == '' ? 'Tất cả' : _string;
}
