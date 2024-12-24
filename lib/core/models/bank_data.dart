class BankData {
  String? id;
  String? name;
  String? logo;

  BankData({
    this.id,
    this.name,
    this.logo,
  });

  BankData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    return map;
  }
}
