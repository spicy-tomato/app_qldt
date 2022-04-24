import 'package:json_annotation/json_annotation.dart';

enum AccountRole {
  empty,
  guest,
  @JsonValue(1)
  student,
  @JsonValue(2)
  teacher,
  @JsonValue(3)
  departmentAuthorized,
  @JsonValue(4)
  departmentDeputyHead,
  @JsonValue(5)
  departmentHead,
  @JsonValue(6)
  facultyAuthorized,
  @JsonValue(7)
  facultyDeputyHead,
  @JsonValue(8)
  facultyHead,
  @JsonValue(9)
  teachingManager,
  @JsonValue(10)
  roomManager,
  @JsonValue(11)
  admin
}

extension AccountRoleExtension on AccountRole {
  bool get isUser => index >= 1;
}
