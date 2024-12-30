import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/features/account_management/data/models/account_data.dart';
import 'default_account.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? mobileNumber;
  String? address;
  String? id;
  List<BankAccountData>? bankAccounts;
  Role? role;
  DefaultAcc? defaultAcc;

  UserModel._();
  static final UserModel _singletonInstance = UserModel._();
  static UserModel get instance => _singletonInstance;

  setFromjson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    id = json['_id'];
    defaultAcc = json["defaultAcc"] == null ? null : DefaultAcc.fromJson(json["defaultAcc"]);
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    role = Role.fromJson(json['role']);
  }
}
