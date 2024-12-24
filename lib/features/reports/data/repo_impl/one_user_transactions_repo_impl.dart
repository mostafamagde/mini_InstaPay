import 'package:untitled2/core/enums/transaction_status_enum.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/reports/data/models/one_user_transactions_model.dart';
import 'package:untitled2/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/one_user_transactions_repo.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class OneUserTransactionsRepoImpl extends OneUserTransactionsRepo {
  @override
  List<OneUserTransactionsModel> getOneUserTransactionsForUser(List<TransactionModel> transactionModels) {
    Map<String, OneUserTransactionsModel> data = {};

    for (TransactionModel transaction in transactionModels) {
      if (transaction.sender.id == UserModel.getInstance().id) {
        if (data.containsKey(transaction.receiver.id)) {
          OneUserTransactionsModel model = data[transaction.receiver.id]!;
          if (transaction.status == TransactionStatus.SUCCESS.value) {
            model.transactionSummaryModel.addSuccessSend(transaction.amount);
          } else {
            model.transactionSummaryModel.totalFailedTransactions++;
          }
        } else {
          late UserTransactionSummaryModel user;
          if (transaction.status == TransactionStatus.SUCCESS.value) {
            user = UserTransactionSummaryModel.initSuccessSend(transaction.amount);
          } else {
            user = UserTransactionSummaryModel.initFailed();
          }

          data[transaction.receiver.id] = OneUserTransactionsModel(
            iamReciever: false,
            user: transaction.receiver,
            transactionSummaryModel: user,
          );
        }
      } else if (transaction.receiver.id == UserModel.getInstance().id) {
        if (data.containsKey(transaction.sender.id)) {
          OneUserTransactionsModel model = data[transaction.sender.id]!;
          if (transaction.status == TransactionStatus.SUCCESS.value) {
            model.transactionSummaryModel.addSuccessRecv(transaction.amount);
          } else {
            model.transactionSummaryModel.totalFailedTransactions++;
          }
        } else {
          late UserTransactionSummaryModel user;
          if (transaction.status == TransactionStatus.SUCCESS.value) {
            user = UserTransactionSummaryModel.initSuccessRecv(transaction.amount);
          } else {
            user = UserTransactionSummaryModel.initFailed();
          }

          data[transaction.sender.id] = OneUserTransactionsModel(
            iamReciever: true,
            user: transaction.sender,
            transactionSummaryModel: user,
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

  @override
  List<OneUserTransactionsModel> getOneUserTransactionsForAdmin(List<TransactionModel> transactionModels) {
    Map<String, OneUserTransactionsModel> data = {};

    for (TransactionModel transaction in transactionModels) {
      if (data.containsKey(transaction.receiver.id)) {
        OneUserTransactionsModel model = data[transaction.receiver.id]!;
        if (transaction.status == TransactionStatus.SUCCESS.value) {
          model.transactionSummaryModel.addSuccessRecv(transaction.amount);
        } else {
          model.transactionSummaryModel.totalFailedTransactions++;
        }
      } else {
        late UserTransactionSummaryModel user;
        if (transaction.status == TransactionStatus.SUCCESS.value) {
          user = UserTransactionSummaryModel.initSuccessRecv(transaction.amount);
        } else {
          user = UserTransactionSummaryModel.initFailed();
        }

        data[transaction.receiver.id] = OneUserTransactionsModel(
          iamReciever: false,
          user: transaction.receiver,
          transactionSummaryModel: user,
        );
      }
      if (data.containsKey(transaction.sender.id)) {
        OneUserTransactionsModel model = data[transaction.sender.id]!;
        if (transaction.status == TransactionStatus.SUCCESS.value) {
          model.transactionSummaryModel.addSuccessSend(transaction.amount);
        } else {
          model.transactionSummaryModel.totalFailedTransactions++;
        }
      } else {
        late UserTransactionSummaryModel user;

        if (transaction.status == TransactionStatus.SUCCESS.value) {
          user = UserTransactionSummaryModel.initSuccessSend(transaction.amount);
        } else {
          user = UserTransactionSummaryModel.initFailed();
        }

        data[transaction.sender.id] = OneUserTransactionsModel(
          iamReciever: true,
          user: transaction.sender,
          transactionSummaryModel: user,
        );
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
