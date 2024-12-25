enum TransactionType {
  Send('Send'),
  Recieve('Recieve');

  final String value;

  const TransactionType(this.value);

  factory TransactionType.fromJson(String value) {
    for (TransactionType type in TransactionType.values) {
      if (type.value == value) {
        return type;
      }
    }

    return TransactionType.Send;
  }
}
