import 'Data.dart';

class BankAccountModel {
  BankAccountModel({
    this.message,
    this.status,
    this.data,
  });

  BankAccountModel.fromJson(dynamic json) {
    message = json['message'];

    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? message;

  bool? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
