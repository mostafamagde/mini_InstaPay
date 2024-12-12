import 'BankId.dart';

class DefaultAcc {
  DefaultAcc({
      this.id, 
      this.bankId,});

  DefaultAcc.fromJson(dynamic json) {
    id = json['_id'];
    bankId = json['bankId'] != null ? BankId.fromJson(json['bankId']) : null;
  }
  String? id;
  BankId? bankId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (bankId != null) {
      map['bankId'] = bankId?.toJson();
    }
    return map;
  }

}