import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');

  const Username.dirty(String value) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null;
    } else {
      return UsernameValidationError.empty;
    }
  }
}
