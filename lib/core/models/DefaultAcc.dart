

import 'BankId.dart';
import 'CardId.dart';

class DefaultAcc {
  DefaultAcc({
      this.id, 
      this.bankId,this.cardInfo});

  DefaultAcc.fromJson(dynamic json) {
    id = json['_id'];
    bankId = json['bankId'] != null ? BankId.fromJson(json['bankId']) : null;
    cardInfo = json['cardId'] != null ? CardId.fromJson(json['cardId']) : null;
  }
  String? id;
  BankId? bankId;
  CardId? cardInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (bankId != null) {
      map['bankId'] = bankId?.toJson();
    }
    return map;
  }

}