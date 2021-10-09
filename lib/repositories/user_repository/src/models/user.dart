import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:intl/intl.dart';

class User {
  const User({
    this.id = '',
    this.name = '',
    this.dob,
    this.idClass,
    this.idCardNumber,
    this.phoneNumberStudent,
    this.address,
    this.accountId,
    this.permission = AccountPermission.user,
  });

  final String id;
  final String name;
  final DateTime? dob;
  final String? idClass;
  final String? idCardNumber;
  final String? phoneNumberStudent;
  final String? address;
  final int? accountId;
  final AccountPermission permission;

  factory User.fromJsonWithPermission(Map<String, dynamic> json, AccountPermission permission) {
    return User(
      id: json['id'],
      name: json['name'],
      dob: json['birth'] != null ? DateFormat('yyyy-M-d').parse(json['birth']) : null,
      idClass: json['id_class'],
      idCardNumber: json['id_card_number'],
      phoneNumberStudent: json['phone_number'],
      address: json['address'],
      accountId: json['id_account'],
      permission: permission,
    );
  }

  static const empty = User();
}
