import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/domain/repo_interface/transactions_summary_repo.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

class AdminTransactionsSummaryRepoImpl extends TransactionsSummaryRepo {
  AdminTransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels) {
    AdminTransactionSummaryModel summaryModel = AdminTransactionSummaryModel.init();

    for (TransactionModel model in transactionModels) {
      if (model.status == TransactionStatus.Success.value) {
        summaryModel.totalTransactionsAmount += model.amount;
        summaryModel.totalSuccessTransactions++;
      } else if (model.status != TransactionStatus.Success.value) {
        summaryModel.totalFailedTransactions++;
      }
    }

    summaryModel.totalTransactions = summaryModel.totalSuccessTransactions + summaryModel.totalFailedTransactions;

    return summaryModel;
  }
}
