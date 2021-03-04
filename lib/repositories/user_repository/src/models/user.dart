import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id = '',
    this.name = '',
    this.dob,
    this.idClass,
    this.idCardNumber,
    this.phoneNumberStudent,
    this.address,
  });

  final String id;
  final String name;
  final DateTime? dob;
  final String? idClass;
  final String? idCardNumber;
  final String? phoneNumberStudent;
  final String? address;

  @override
  List<dynamic> get props =>
      [id, name, dob, idCardNumber, phoneNumberStudent, address];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['ID_Student'],
      name: json['Student_Name'],
      dob: json['DoB_Student'],
      idClass: json['ID_Class'],
      idCardNumber: json['ID_Card_Number'],
      phoneNumberStudent: json['Phone_Number_Student'],
      address: json['Address_Student'],
    );
  }

  static const empty = User();
}
