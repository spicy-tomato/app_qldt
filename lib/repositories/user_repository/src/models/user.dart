import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:app_qldt/models/core/simple_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  const User({
    required this.department,
    required this.faculty,
    required this.id,
    required this.name,
    required this.permissions,
    required this.role,
    required this.uuidAccount,
    this.address,
    this.birth,
    this.email,
    this.idCardNumber,
    this.idClass,
    this.isFemale,
    this.notificationDataVersion,
    this.phone,
    this.scheduleDataVersion,
    this.universityTeacherDegree,
  });

  static const empty = User(
      faculty: null,
      id: '',
      notificationDataVersion: -1,
      permissions: [],
      role: AccountRole.guest,
      department: null,
      name: '',
      scheduleDataVersion: -1,
      uuidAccount: '');

  final String uuidAccount;
  final String name;
  final String id;
  final DateTime? birth;
  final String? phone;

  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  final bool? isFemale;
  @JsonKey(name: 'idRole')
  final AccountRole role;
  final int? scheduleDataVersion;
  final int? notificationDataVersion;
  final List<int> permissions;

  final String? idClass;
  final String? idCardNumber;
  final String? address;

  final String? universityTeacherDegree;
  final String? email;
  final SimpleModel? department;
  final SimpleModel? faculty;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get title => isFemale == null
      ? 'Bạn'
      : isFemale!
          ? 'cô'
          : 'thầy';

  static bool? _boolFromInt(int? value) => value == null ? null : value == 1;

  static int? _boolToInt(bool? value) => value == null
      ? null
      : value
          ? 1
          : 0;
}
