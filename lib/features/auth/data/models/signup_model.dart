class SignUpModel {
  String email;
  String password;
  String firstName;
  String lastName;
  String mobileNumber;

  SignUpModel({required this.email, required this.password, required this.firstName, required this.lastName, required this.mobileNumber});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
    };
  }
}
