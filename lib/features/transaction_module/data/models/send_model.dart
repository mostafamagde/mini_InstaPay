class SendModel {
  final String reiceverData;
  final String pin;
  final int amount;
  String? account;
  SendModel({required this.reiceverData, required this.pin, required this.amount, this.account});
}
