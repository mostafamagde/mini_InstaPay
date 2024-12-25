enum TransactionStatus {
  Refunded('Refunded'),
  Refunding('Refunding'),
  Success('Success'),
  Pending('Pending'),
  Failed('Failed'),
  Suspicious('Suspicious');

  final String value;

  const TransactionStatus(this.value);

  static List<String> get allValues {
    return TransactionStatus.values.map<String>((TransactionStatus element) {
      return element.value;
    }).toList();
  }

  factory TransactionStatus.fromJson(String value) {
    for (TransactionStatus status in TransactionStatus.values) {
      if (status.value == value) {
        return status;
      }
    }

    return TransactionStatus.Failed;
  }
}
