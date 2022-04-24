import 'package:app_qldt/repositories/user_repository/src/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

class GenericConverter<T> implements JsonConverter<T, Object?> {
  const GenericConverter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('uuidAccount')) {
        return User.fromJson(json) as T;
      }
    }

    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}
