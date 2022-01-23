import 'package:app_qldt/enums/config/account_permission_enum.dart';
import 'package:intl/intl.dart';

class User {
  const User({
    this.id = '',
    this.name = '',
    this.dob,
    this.isFemale,
    this.idClass,
    this.idCardNumber,
    this.phoneNumberStudent,
    this.address,
    this.accountId,
    this.grantedPermissions,
    this.permission = AccountPermission.user,
  });

  final String id;
  final String name;
  final DateTime? dob;
  final bool? isFemale;
  final String? idClass;
  final String? idCardNumber;
  final String? phoneNumberStudent;
  final String? address;
  final String? accountId;
  final AccountPermission permission;
  final List<int>? grantedPermissions;

  factory User.fromJsonWithPermission(Map<String, dynamic> json, AccountPermission permission) {
    return User(
        id: json['data']['uuid'],
        name: json['data']['name'],
        dob: json['data']['birth'] != null ? DateFormat('yyyy-M-d').parse(json['data']['birth']) : null,
        isFemale: json['data']['is_female'] == 1,
        idClass: json['data']['id_class'],
        idCardNumber: json['data']['id_card_number'],
        phoneNumberStudent: json['data']['phone_number'],
        address: json['data']['address'],
        accountId: json['data']['uuid_account'],
        permission: permission,
        grantedPermissions: (json['data']['permissions'] as List<dynamic>).cast<int>()
    );
  }

  static const empty = User();
}
