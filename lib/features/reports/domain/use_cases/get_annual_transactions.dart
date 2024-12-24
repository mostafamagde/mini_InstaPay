import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/repo_impl/admin_transactions_summary_repo_impl.dart';
import 'package:untitled2/features/reports/data/repo_impl/user_transactions_summary_repo_impl.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetAnnualTransactions {
  const GetAnnualTransactions(this._transactionRepo, this._userTransactionsSummaryRepoImpl, this._adminTransactionsSummaryRepoImpl);

  final TransactionRepository _transactionRepo;
  final UserTransactionsSummaryRepoImpl _userTransactionsSummaryRepoImpl;
  final AdminTransactionsSummaryRepoImpl _adminTransactionsSummaryRepoImpl;

  Future<TransactionSummaryModel> getAnnualTransactions(int year) async {
    try {
      late List<TransactionModel> result;
      if (UserModel.getInstance().role == 'Admin') {
        result = await _transactionRepo.getAllTransactions();
        return _adminTransactionsSummaryRepoImpl.getTransactionSummaryModel(
          result.where((TransactionModel model) => model.createdAt.year == year).toList(),
        );
      } else {
        result = await _transactionRepo.getUserTransactions();
        return _userTransactionsSummaryRepoImpl.getTransactionSummaryModel(
          result.where((TransactionModel model) => model.createdAt.year == year).toList(),
        );
      }
    } catch (_) {
      if (UserModel.getInstance().role == 'Admin') {
        return AdminTransactionSummaryModel.init();
      } else {
        return UserTransactionSummaryModel.init();
      }
    }
  }
}
