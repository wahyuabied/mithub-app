enum UserRole {
  mitra('Mitra'),
  agent('Agent');

  final String value;
  const UserRole(this.value);
}

// String? to UserRole
extension NullableUserRoleExt on String? {
  UserRole? toUserRole() {
    if (this == null) {
      return null;
    } else {
      return UserRole.values.firstWhere((element) => this == element.value);
    }
  }
}

// String to UserRole
extension UserRoleExt on String {
  UserRole toUserRole() {
    return UserRole.values.firstWhere((element) => this == element.value);
  }
}
