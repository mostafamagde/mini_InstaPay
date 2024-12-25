enum Role {
  Admin('Admin'),
  User('User');

  final String value;

  const Role(this.value);

  factory Role.fromJson(String value) {
    for (Role role in Role.values) {
      if (role.value == value) {
        return role;
      }
    }

    return Role.User;
  }
}
