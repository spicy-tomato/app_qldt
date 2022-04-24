import 'package:json_annotation/json_annotation.dart';

class BooleanConverter implements JsonConverter<bool, Object> {
  const BooleanConverter();

  @override
  bool fromJson(Object value) {
    return value != 0;
  }

  @override
  Object toJson(bool value) => value ? 1 : 0;
}
