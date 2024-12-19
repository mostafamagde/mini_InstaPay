class BankId {
  BankId({
    this.id,
    this.name,
    this.logo,
  });

  BankId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    logo = json['logo'];
  }
  String? id;
  String? name;
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    return map;
  }
}
