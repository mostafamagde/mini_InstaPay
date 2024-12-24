import 'package:untitled2/core/enums/transaction_status_enum.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/reports/data/models/one_user_transactions_model.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/one_user_transactions_repo.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class OneUserTransactionsRepoImpl extends OneUserTransactionsRepo {
  @override
  List<OneUserTransactionsModel> getOneUserTransactions(List<TransactionModel> transactionModels) {
    Map<String, OneUserTransactionsModel> data = {};

    for (TransactionModel transaction in transactionModels) {
      if (transaction.sender.id == UserModel.getInstance().id) {
        if (data.containsKey(transaction.receiver.id)) {
          OneUserTransactionsModel model = data[transaction.receiver.id]!;
          model.transactionSummaryModel.totalSend += transaction.amount;
          model.transactionSummaryModel.totalNet -= transaction.amount;
          model.transactionSummaryModel.totalSendTransactions++;
          model.transactionSummaryModel.totalSuccessTransactions += transaction.status == TransactionStatus.SUCCESS.value ? 1 : 0;
          model.transactionSummaryModel.totalFailedTransactions += transaction.status != TransactionStatus.SUCCESS.value ? 1 : 0;
        } else {
          data[transaction.receiver.id] = OneUserTransactionsModel(
            iamReciever: false,
            user: transaction.receiver,
            transactionSummaryModel: TransactionSummaryModel(
              totalSend: transaction.amount,
              totalReceive: 0,
              totalNet: -transaction.amount,
              totalSendTransactions: 1,
              totalReceiveTransactions: 0,
              totalSuccessTransactions: transaction.status == TransactionStatus.SUCCESS.value ? 1 : 0,
              totalFailedTransactions: transaction.status != TransactionStatus.SUCCESS.value ? 1 : 0,
            ),
          );
        }
      } else if (transaction.receiver.id == UserModel.getInstance().id) {
        if (data.containsKey(transaction.sender.id)) {
          OneUserTransactionsModel model = data[transaction.sender.id]!;
          model.transactionSummaryModel.totalReceive += transaction.amount;
          model.transactionSummaryModel.totalNet += transaction.amount;
          model.transactionSummaryModel.totalReceiveTransactions++;
          model.transactionSummaryModel.totalSuccessTransactions += transaction.status == TransactionStatus.SUCCESS.value ? 1 : 0;
          model.transactionSummaryModel.totalFailedTransactions += transaction.status != TransactionStatus.SUCCESS.value ? 1 : 0;
        } else {
          data[transaction.sender.id] = OneUserTransactionsModel(
            iamReciever: true,
            user: transaction.sender,
            transactionSummaryModel: TransactionSummaryModel(
              totalSend: 0,
              totalReceive: transaction.amount,
              totalNet: transaction.amount,
              totalSendTransactions: 0,
              totalReceiveTransactions: 1,
              totalSuccessTransactions: transaction.status == TransactionStatus.SUCCESS.value ? 1 : 0,
              totalFailedTransactions: transaction.status != TransactionStatus.SUCCESS.value ? 1 : 0,
            ),
          );
        }
      }
    }

    return List<OneUserTransactionsModel>.generate(
      data.length,
      (index) {
        return data.entries.elementAt(index).value;
      },
    );
  }
}
