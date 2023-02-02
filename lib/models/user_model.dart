class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        email: map['email'],
        firstName: map['first_name'] ?? 'First Name',
        lastName: map['last_name'] ?? 'Last Name',
        avatar: map['avatar'] ?? 'Some icon');
  }
}
