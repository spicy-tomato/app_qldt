import 'package:intl/intl.dart';
import 'package:app_qldt/_models/account_permission_enum.dart';

class User {
  const User({
    this.id = '',
    this.name = '',
    this.dob,
    this.idClass,
    this.idCardNumber,
    this.phoneNumberStudent,
    this.address,
    this.accountId = '',
    this.permission = AccountPermission.user,
  });

  final String id;
  final String name;
  final DateTime? dob;
  final String? idClass;
  final String? idCardNumber;
  final String? phoneNumberStudent;
  final String? address;
  final String accountId;
  final AccountPermission permission;

  factory User.fromJsonWithPermission(Map<String, dynamic> json, AccountPermission permission) {
    return User(
      id: json['ID_Student'],
      name: json['Student_Name'],
      dob: json['DoB_Student'] != null ? DateFormat('yyyy-M-d').parse(json['DoB_Student']) : null,
      idClass: json['ID_Class'],
      idCardNumber: json['ID_Card_Number'],
      phoneNumberStudent: json['Phone_Number_Student'],
      address: json['Address_Student'],
      accountId: json['ID_Account'],
      permission: permission,
    );
  }

  static const empty = User();
}
