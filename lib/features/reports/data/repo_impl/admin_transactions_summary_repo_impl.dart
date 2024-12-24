import 'package:untitled2/core/enums/transaction_status_enum.dart';
import 'package:untitled2/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/transactions_summary_repo.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class AdminTransactionsSummaryRepoImpl extends TransactionsSummaryRepo {
  AdminTransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels) {
    AdminTransactionSummaryModel summaryModel = AdminTransactionSummaryModel.init();

    for (TransactionModel model in transactionModels) {
      if (model.status == TransactionStatus.SUCCESS.value) {
        summaryModel.totalTransactionsAmount += model.amount;
        summaryModel.totalSuccessTransactions++;
      } else if (model.status != TransactionStatus.SUCCESS.value) {
        summaryModel.totalFailedTransactions++;
      }
    }

    summaryModel.totalTransactions = summaryModel.totalSuccessTransactions + summaryModel.totalFailedTransactions;

    return summaryModel;
  }
}
