import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';

import 'DefaultAcc.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? mobileNumber;
  String? address;
  String? id;
  BankAccountModel? bankAccounts;

  DefaultAcc? defaultAcc;

  static final UserModel _singleton = UserModel._internal();

  factory UserModel.getInstance() {
    return _singleton;
  }

  setFromjson(Map<String, dynamic> json) {
    print(json);
    firstName = json['firstName'];
    id = json['_id'];
    defaultAcc = json["defaultAcc"] == null ? null : DefaultAcc.fromJson(json["defaultAcc"]);

    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
  }

  UserModel._internal();
}
