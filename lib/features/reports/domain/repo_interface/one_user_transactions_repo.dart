import 'package:mini_instapay/features/reports/data/models/one_user_transactions_model.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

abstract class OneUserTransactionsRepo {
  List<OneUserTransactionsModel> getOneUserTransactionsForUser(List<TransactionModel> transactionModels);
  List<OneUserTransactionsModel> getOneUserTransactionsForAdmin(List<TransactionModel> transactionModels);
}
