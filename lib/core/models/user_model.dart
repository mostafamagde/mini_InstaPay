class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? userToken;


  static final UserModel _singleton = UserModel._internal();

  factory UserModel.getInstance() {
    return _singleton;
  }
  setFromjson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  UserModel._internal();
}