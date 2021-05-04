import 'package:formz/formz.dart';

enum PasswordValidateError { empty }

class Password extends FormzInput<String, PasswordValidateError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  @override
  PasswordValidateError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null;
    } else {
      return PasswordValidateError.empty;
    }
  }
}
