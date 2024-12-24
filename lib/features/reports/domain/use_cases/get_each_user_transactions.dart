import 'package:untitled2/features/reports/data/models/one_user_transactions_model.dart';
import 'package:untitled2/features/reports/domain/repo_interface/one_user_transactions_repo.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetEachUserTransactions {
  const GetEachUserTransactions(this._transactionRepo, this.oneUserTransactionsRepo);

  final TransactionRepository _transactionRepo;
  final OneUserTransactionsRepo oneUserTransactionsRepo;

  Future<List<OneUserTransactionsModel>> getAnnualTransactions(int year) async {
    try {
      List<TransactionModel> result = await _transactionRepo.getUserTransactions();
      return oneUserTransactionsRepo.getOneUserTransactions(result);
    } catch (_) {
      return [];
    }
  }
}
