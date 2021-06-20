import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class UsernameModel extends FormzInput<String, UsernameValidationError> {
  const UsernameModel.pure() : super.pure('');

  const UsernameModel.dirty(String value) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null;
    } else {
      return UsernameValidationError.empty;
    }
  }
}
