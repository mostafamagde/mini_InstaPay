import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? mobileNumber;
  String? address;

  BankAccountModel? bankAccounts;



  static final UserModel _singleton = UserModel._internal();

  factory UserModel.getInstance() {
    return _singleton;
  }
  setFromjson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber =json['mobileNumber'];
    address =json['address'];
  }

  UserModel._internal();
}