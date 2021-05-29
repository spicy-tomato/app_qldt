class SemesterModel {
  final String _string;

  const SemesterModel([String? semester]) : this._string = semester == null ? '' : semester;

  static SemesterModel get all => SemesterModel();

  static String getString(SemesterModel semester) => semester.toString();

  String get query => _string;

  @override
  bool operator ==(Object other) {
    return other is SemesterModel && _string == other._string;
  }

  @override
  int get hashCode => _string.hashCode;

  @override
  String toString() => _string == '' ? 'Tất cả' : _string;
}
