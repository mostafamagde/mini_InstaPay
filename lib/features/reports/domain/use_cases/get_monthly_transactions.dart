import 'package:untitled2/features/reports/data/enums/months_enum.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/repo_impl/transactions_summary_repo_impl.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetMonthlyTransactions {
  const GetMonthlyTransactions(this._transactionRepo, this.transactionsSummaryRepoImpl);

  final TransactionRepository _transactionRepo;
  final TransactionsSummaryRepoImpl transactionsSummaryRepoImpl;

  Future<TransactionSummaryModel> getMonthlyTransactions(String month, int year) async {
    List<TransactionModel> result = await _transactionRepo.getUserTransactions();
    return transactionsSummaryRepoImpl.getTransactionSummaryModel(
      result.where((TransactionModel model) => model.createdAt.month - 1 == Month.getMonthNum(month) && model.createdAt.year == year).toList(),
    );
  }
}
