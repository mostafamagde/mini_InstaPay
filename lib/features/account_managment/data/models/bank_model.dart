class BankModel {
  final String logo;
  final String name;
  final String id;
  BankModel(this.id, {required this.logo, required this.name});

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      json['_id'],
      logo: json['logo'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'logo': logo,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'BankModel(id: $id, logo: $logo, name: $name)';
  }
}
