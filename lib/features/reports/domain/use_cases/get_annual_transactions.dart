import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/transactions_summary_repo_interface.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetAnnualTransactions {
  const GetAnnualTransactions(this._transactionRepo, this.transactionsSummaryRepo);

  final TransactionRepository _transactionRepo;
  final TransactionsSummaryRepo transactionsSummaryRepo;

  Future<TransactionSummaryModel> getAnnualTransactions(int year) async {
    try {
      List<TransactionModel> result = await _transactionRepo.getUserTransactions();
      return transactionsSummaryRepo.getTransactionSummaryModel(
        result.where((TransactionModel model) => model.createdAt.year == year).toList(),
      );
    } catch (_) {
      return TransactionSummaryModel.init();
    }
  }
}
