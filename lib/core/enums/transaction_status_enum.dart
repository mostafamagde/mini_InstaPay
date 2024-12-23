enum TransactionStatus {
  REFUNDED('Refunded'),
  REFUNDING('Refunding'),
  SUCCESS('Success'),
  PENDING('Pending'),
  FAILED('Failed'),
  SUSPICIOUS('Suspicious');

  final String value;

  const TransactionStatus(this.value);

  static List<String> get allValues {
    return TransactionStatus.values.map<String>((TransactionStatus element) {
      return element.value;
    }).toList();
  }
}
