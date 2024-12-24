import 'package:untitled2/core/enums/transaction_status_enum.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/transactions_summary_repo.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class UserTransactionsSummaryRepoImpl extends TransactionsSummaryRepo {
  UserTransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels) {
    UserTransactionSummaryModel summaryModel = UserTransactionSummaryModel.init();

    for (TransactionModel model in transactionModels) {
      if (model.status == TransactionStatus.SUCCESS.value) {
        if (model.sender.id == UserModel.getInstance().id) {
          summaryModel.totalSendTransactions++;
        } else if (model.receiver.id == UserModel.getInstance().id) {
          summaryModel.totalReceiveTransactions++;
        }

        if (model.sender.id == UserModel.getInstance().id) {
          summaryModel.totalSend += model.amount;
        } else if (model.receiver.id == UserModel.getInstance().id) {
          summaryModel.totalReceive += model.amount;
        }
        summaryModel.totalSuccessTransactions++;
      } else if (model.status != TransactionStatus.SUCCESS.value) {
        summaryModel.totalFailedTransactions++;
      }
    }

    summaryModel.totalNet = summaryModel.totalReceive - summaryModel.totalSend;

    return summaryModel;
  }
}
