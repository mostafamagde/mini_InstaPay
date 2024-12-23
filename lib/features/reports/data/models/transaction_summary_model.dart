class TransactionSummaryModel {
  double totalSend;
  double totalReceive;
  double totalNet;
  int totalSendTransactions;
  int totalReceiveTransactions;
  int totalSuccessTransactions;
  int totalFailedTransactions;

  TransactionSummaryModel({
    required this.totalSend,
    required this.totalReceive,
    required this.totalNet,
    required this.totalSendTransactions,
    required this.totalReceiveTransactions,
    required this.totalSuccessTransactions,
    required this.totalFailedTransactions,
  });

  factory TransactionSummaryModel.init() {
    return TransactionSummaryModel(
      totalSend: 0.0,
      totalReceive: 0.0,
      totalNet: 0.0,
      totalSendTransactions: 0,
      totalReceiveTransactions: 0,
      totalSuccessTransactions: 0,
      totalFailedTransactions: 0,
    );
  }
}
