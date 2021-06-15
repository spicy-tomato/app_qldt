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
    this.accountId = '',
  });

  final String id;
  final String name;
  final DateTime? dob;
  final String? idClass;
  final String? idCardNumber;
  final String? phoneNumberStudent;
  final String? address;
  final String accountId;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID_Student'],
      name: json['Student_Name'],
      dob: DateFormat('yyyy-M-d').parse(json['DoB_Student']),
      idClass: json['ID_Class'],
      idCardNumber: json['ID_Card_Number'],
      phoneNumberStudent: json['Phone_Number_Student'],
      address: json['Address_Student'],
      accountId: json['ID_Account'],
    );
  }

  static const empty = User();
}
