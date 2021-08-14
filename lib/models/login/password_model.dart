import 'package:formz/formz.dart';

enum PasswordValidateError { empty }

class PasswordModel extends FormzInput<String, PasswordValidateError> {
  const PasswordModel.pure() : super.pure('');

  const PasswordModel.dirty(String value) : super.dirty(value);

  @override
  PasswordValidateError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null;
    } else {
      return PasswordValidateError.empty;
    }
  }
}
