enum UserStatus {
  existingUser('EXISTING_USER'),
  newUser('NEW_USER');

  const UserStatus(this.value);
  final String value;

  factory UserStatus.fromValue(String value) {
    switch (value) {
      case 'EXISTING_USER':
        return UserStatus.newUser;
      default:
        return UserStatus.existingUser;
    }
  }
}
