import 'package:mini_instapay/features/reports/data/models/transaction_summary_model.dart';

class AdminTransactionSummaryModel extends TransactionSummaryModel {
  double totalTransactionsAmount;
  int totalTransactions;
  int totalSuccessTransactions;
  int totalFailedTransactions;

  AdminTransactionSummaryModel({
    required this.totalTransactionsAmount,
    required this.totalTransactions,
    required this.totalSuccessTransactions,
    required this.totalFailedTransactions,
  });

  factory AdminTransactionSummaryModel.init() {
    return AdminTransactionSummaryModel(
      totalTransactionsAmount: 0.0,
      totalTransactions: 0,
      totalSuccessTransactions: 0,
      totalFailedTransactions: 0,
    );
  }
}
