class CardId {
  CardId({
      this.id, 
      this.cardNo,});

  CardId.fromJson(dynamic json) {
    id = json['_id'];
    cardNo = json['cardNo'];
  }
  String? id;
  String? cardNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cardNo'] = cardNo;
    return map;
  }

}