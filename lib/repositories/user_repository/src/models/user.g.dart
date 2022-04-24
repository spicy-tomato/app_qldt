// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      department: json['department'] == null
          ? null
          : SimpleModel<dynamic, dynamic>.fromJson(
              json['department'] as Map<String, dynamic>),
      faculty: json['faculty'] == null
          ? null
          : SimpleModel<dynamic, dynamic>.fromJson(
              json['faculty'] as Map<String, dynamic>),
      id: json['id'] as String,
      name: json['name'] as String,
      permissions:
          (json['permissions'] as List<dynamic>).map((e) => e as int).toList(),
      role: $enumDecode(_$AccountRoleEnumMap, json['idRole']),
      uuidAccount: json['uuidAccount'] as String,
      address: json['address'] as String?,
      birth: json['birth'] == null
          ? null
          : DateTime.parse(json['birth'] as String),
      email: json['email'] as String?,
      idCardNumber: json['idCardNumber'] as String?,
      idClass: json['idClass'] as String?,
      isFemale: User._boolFromInt(json['isFemale'] as int?),
      notificationDataVersion: json['notificationDataVersion'] as int?,
      phone: json['phone'] as String?,
      scheduleDataVersion: json['scheduleDataVersion'] as int?,
      universityTeacherDegree: json['universityTeacherDegree'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuidAccount': instance.uuidAccount,
      'name': instance.name,
      'id': instance.id,
      'birth': instance.birth?.toIso8601String(),
      'phone': instance.phone,
      'isFemale': User._boolToInt(instance.isFemale),
      'idRole': _$AccountRoleEnumMap[instance.role],
      'scheduleDataVersion': instance.scheduleDataVersion,
      'notificationDataVersion': instance.notificationDataVersion,
      'permissions': instance.permissions,
      'idClass': instance.idClass,
      'idCardNumber': instance.idCardNumber,
      'address': instance.address,
      'universityTeacherDegree': instance.universityTeacherDegree,
      'email': instance.email,
      'department': instance.department?.toJson(),
      'faculty': instance.faculty?.toJson(),
    };

const _$AccountRoleEnumMap = {
  AccountRole.empty: 'empty',
  AccountRole.guest: 'guest',
  AccountRole.student: 1,
  AccountRole.teacher: 2,
  AccountRole.departmentAuthorized: 3,
  AccountRole.departmentDeputyHead: 4,
  AccountRole.departmentHead: 5,
  AccountRole.facultyAuthorized: 6,
  AccountRole.facultyDeputyHead: 7,
  AccountRole.facultyHead: 8,
  AccountRole.teachingManager: 9,
  AccountRole.roomManager: 10,
  AccountRole.admin: 11,
};
