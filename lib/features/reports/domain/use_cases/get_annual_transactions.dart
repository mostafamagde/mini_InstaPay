import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/data/models/transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/data/repo_impl/admin_transactions_summary_repo_impl.dart';
import 'package:mini_instapay/features/reports/data/repo_impl/user_transactions_summary_repo_impl.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';
import 'package:mini_instapay/features/transactions/data/repository/transaction_repo.dart';

class GetAnnualTransactions {
  const GetAnnualTransactions(this._transactionRepo, this._userTransactionsSummaryRepoImpl, this._adminTransactionsSummaryRepoImpl);

  final TransactionRepository _transactionRepo;
  final UserTransactionsSummaryRepoImpl _userTransactionsSummaryRepoImpl;
  final AdminTransactionsSummaryRepoImpl _adminTransactionsSummaryRepoImpl;

  Future<TransactionSummaryModel> getAnnualTransactions(int year) async {
    try {
      late List<TransactionModel> result;
      if (UserModel.instance.role == Role.admin) {
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
      if (UserModel.instance.role == Role.admin) {
        return AdminTransactionSummaryModel.init();
      } else {
        return UserTransactionSummaryModel.init();
      }
    }
  }
}
