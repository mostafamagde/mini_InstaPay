class Data {
  Data({
      this.id, 
      this.bankId, 
      this.userId, 
      this.cardNo,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    bankId = json['bankId'];
    userId = json['userId'];
    cardNo = json['cardNo'];
  }
  String? id;
  String? bankId;
  String? userId;
  String? cardNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['bankId'] = bankId;
    map['userId'] = userId;
    map['cardNo'] = cardNo;
    return map;
  }

}