import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/features/account_managment/data/models/account_data.dart';
import 'DefaultAcc.dart';

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
    this.firstName = json['firstName'];
    this.id = json['_id'];
    this.defaultAcc = json["defaultAcc"] == null ? null : DefaultAcc.fromJson(json["defaultAcc"]);
    this.lastName = json['lastName'];
    this.email = json['email'];
    this.mobileNumber = json['mobileNumber'];
    this.address = json['address'];
    this.role = Role.fromJson(json['role']);
  }
}
