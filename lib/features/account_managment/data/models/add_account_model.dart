class AddAccountModel {
  final String cardNumber;
  final String cardHolderName;
  final String expirationDate;
  final String cvv;
  final String pin;
  final String bankId;

  AddAccountModel({required this.cardNumber, required this.cardHolderName, required this.expirationDate, required this.cvv, required this.pin, required this.bankId});
}
