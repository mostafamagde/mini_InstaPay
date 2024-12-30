class AdminUsersModel {
  AdminUsersModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.role,
    this.status,
    this.confirmEmail,
    this.createdAt,
    this.userName,
  });

  AdminUsersModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    role = json['role'];
    status = json['status'];
    confirmEmail = json['confirmEmail'];
    createdAt = json['createdAt'];
    userName = json['userName'];
  }

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? role;
  String? status;
  bool? confirmEmail;
  String? createdAt;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['mobileNumber'] = mobileNumber;
    map['role'] = role;
    map['status'] = status;
    map['confirmEmail'] = confirmEmail;
    map['createdAt'] = createdAt;
    map['userName'] = userName;

    return map;
  }
}
