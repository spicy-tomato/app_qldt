enum AccountPermission { user, guest }

extension AccountPermissionExtension on AccountPermission {
  bool get isUser => this == AccountPermission.user;

  bool get isGuest => this == AccountPermission.guest;
}
