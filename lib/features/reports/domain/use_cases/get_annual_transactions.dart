import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetAnnualTransactions {
  const GetAnnualTransactions(this._transactionRepo);

  final TransactionRepository _transactionRepo;

  Future<List<TransactionModel>> getAnnualTransactions(int year) async {
    List<TransactionModel> result = await _transactionRepo.getUserTransactions();
    return result.where((TransactionModel model) => model.createdAt.year == year).toList();
  }
}
