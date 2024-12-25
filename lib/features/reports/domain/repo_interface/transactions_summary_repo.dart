import 'package:mini_instapay/features/reports/data/models/transaction_summary_model.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

abstract class TransactionsSummaryRepo {
  TransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels);
}
