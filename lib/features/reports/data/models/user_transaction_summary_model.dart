import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';

class UserTransactionSummaryModel extends TransactionSummaryModel {
  double totalSend;
  double totalReceive;
  double totalNet;
  int totalSendTransactions;
  int totalReceiveTransactions;
  int totalSuccessTransactions;
  int totalFailedTransactions;

  UserTransactionSummaryModel({
    required this.totalSend,
    required this.totalReceive,
    required this.totalNet,
    required this.totalSendTransactions,
    required this.totalReceiveTransactions,
    required this.totalSuccessTransactions,
    required this.totalFailedTransactions,
  });

  factory UserTransactionSummaryModel.init() {
    return UserTransactionSummaryModel(
      totalSend: 0.0,
      totalReceive: 0.0,
      totalNet: 0.0,
      totalSendTransactions: 0,
      totalReceiveTransactions: 0,
      totalSuccessTransactions: 0,
      totalFailedTransactions: 0,
    );
  }

  factory UserTransactionSummaryModel.initFailed() {
    return UserTransactionSummaryModel(
      totalSend: 0.0,
      totalReceive: 0.0,
      totalNet: 0.0,
      totalSendTransactions: 0,
      totalReceiveTransactions: 0,
      totalSuccessTransactions: 0,
      totalFailedTransactions: 1,
    );
  }

  factory UserTransactionSummaryModel.initSuccessSend(double amount) {
    UserTransactionSummaryModel user = UserTransactionSummaryModel.init();
    user.addSuccessSend(amount);
    return user;
  }

  factory UserTransactionSummaryModel.initSuccessRecv(double amount) {
    UserTransactionSummaryModel user = UserTransactionSummaryModel.init();
    user.addSuccessRecv(amount);
    return user;
  }

  void addSuccessSend(double amount) {
    totalSend += amount;
    totalNet -= amount;
    totalSendTransactions++;
    totalSuccessTransactions++;
  }

  void addSuccessRecv(double amount) {
    totalReceive += amount;
    totalNet += amount;
    totalReceiveTransactions++;
    totalSuccessTransactions++;
  }
}
