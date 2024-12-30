import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/domain/repo_interface/transactions_summary_repo.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

class UserTransactionsSummaryRepoImpl extends TransactionsSummaryRepo {
  @override
  UserTransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels) {
    UserTransactionSummaryModel summaryModel = UserTransactionSummaryModel.init();

    for (TransactionModel model in transactionModels) {
      if (model.status == TransactionStatus.success) {
        if (model.sender.id == UserModel.instance.id) {
          summaryModel.totalSendTransactions++;
        } else if (model.receiver.id == UserModel.instance.id) {
          summaryModel.totalReceiveTransactions++;
        }

        if (model.sender.id == UserModel.instance.id) {
          summaryModel.totalSend += model.amount;
        } else if (model.receiver.id == UserModel.instance.id) {
          summaryModel.totalReceive += model.amount;
        }
        summaryModel.totalSuccessTransactions++;
      } else if (model.status != TransactionStatus.success) {
        summaryModel.totalFailedTransactions++;
      }
    }

    summaryModel.totalNet = summaryModel.totalReceive - summaryModel.totalSend;

    return summaryModel;
  }
}
