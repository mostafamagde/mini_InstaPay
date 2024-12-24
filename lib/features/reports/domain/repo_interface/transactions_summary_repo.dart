import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

abstract class TransactionsSummaryRepo {
  TransactionSummaryModel getTransactionSummaryModel(List<TransactionModel> transactionModels);
}
