enum TransactionRange {
  Annual('Annual'),
  Monthly('Monthly');

  final String value;

  const TransactionRange(this.value);

  static List<String> get allValues {
    return TransactionRange.values.map<String>((TransactionRange element) {
      return element.value;
    }).toList();
  }
}