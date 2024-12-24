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
  String? role;
  DefaultAcc? defaultAcc;

  // static final UserModel _singleton = UserModel._internal();

  // factory UserModel.instance {
  //   return _singleton;
  // }

  static UserModel get instance => UserModel._();

  setFromjson(Map<String, dynamic> json) {
    print(json);
    firstName = json['firstName'];
    id = json['_id'];
    defaultAcc = json["defaultAcc"] == null ? null : DefaultAcc.fromJson(json["defaultAcc"]);
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    role = json['role'];
  }

  UserModel._();
}
