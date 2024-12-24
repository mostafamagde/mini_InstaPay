import 'package:untitled2/core/models/bank_data.dart';

class BankAccountData {
  String? id;
  BankData? bankId;
  String? userId;
  String? cardNo;

  BankAccountData({
    this.id,
    this.bankId,
    this.userId,
    this.cardNo,
  });

  BankAccountData.fromJson(dynamic json) {
    id = json['_id'];
    bankId = BankData.fromJson(json['bankId']);
    userId = json['userId'];
    cardNo = json['cardNo'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['bankId'] = bankId;
    map['userId'] = userId;
    map['cardNo'] = cardNo;
    return map;
  }
}
