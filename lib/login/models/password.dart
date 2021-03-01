import 'package:formz/formz.dart';

enum PasswordValidateError { empty }

class Password extends FormzInput<String, PasswordValidateError> {
  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  @override
  PasswordValidateError validator(String value) {
    return value?.isNotEmpty == true ? null : PasswordValidateError.empty;
  }
}
