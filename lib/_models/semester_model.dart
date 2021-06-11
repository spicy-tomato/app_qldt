class SemesterModel {
  final String? _string;

  const SemesterModel._([String? semester])
      : this._string = semester == null
            ? null
            : semester == ''
                ? ''
                : semester;

  const SemesterModel(String semester) : this._(semester);

  const SemesterModel.all() : this._('');

  const SemesterModel.none() : this._();

  static String getString(SemesterModel semester) => semester.toString();

  String get query => _string!;

  bool get hasData => _string != null;

  @override
  bool operator ==(Object other) {
    return other is SemesterModel && _string == other._string;
  }

  @override
  int get hashCode => _string.hashCode;

  @override
  String toString() => _string == null
      ? 'null'
      : _string == ''
          ? 'Tất cả'
          : _string!;
}
