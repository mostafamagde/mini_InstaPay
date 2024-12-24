import 'package:untitled2/features/reports/data/models/one_user_transactions_model.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

abstract class OneUserTransactionsRepo {
  List<OneUserTransactionsModel> getOneUserTransactions(List<TransactionModel> transactionModels);
}