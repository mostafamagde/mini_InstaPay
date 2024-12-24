class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String userName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userName': userName,
    };
  }

  factory User.init() {
    return User(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      userName: '',
    );
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, userName: $userName)';
  }
}