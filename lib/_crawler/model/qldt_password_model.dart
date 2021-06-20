import 'package:formz/formz.dart';

enum PasswordValidateError { empty }

class QldtPasswordModel extends FormzInput<String, PasswordValidateError> {
  const QldtPasswordModel.pure() : super.pure('');

  const QldtPasswordModel.dirty(String value) : super.dirty(value);

  @override
  PasswordValidateError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null;
    } else {
      return PasswordValidateError.empty;
    }
  }
}
