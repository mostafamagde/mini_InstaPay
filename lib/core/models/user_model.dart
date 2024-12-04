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

  UserModel._internal();
}