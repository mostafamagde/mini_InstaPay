import 'package:untitled2/features/reports/data/models/months_enum.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetMonthlyTransactions {
  const GetMonthlyTransactions(this._transactionRepo);

  final TransactionRepository _transactionRepo;

  Future<List<TransactionModel>> getMonthlyTransactions(String month) async {
    List<TransactionModel> result = await _transactionRepo.getAllTransactions();
    return result.where((TransactionModel model) => model.createdAt.month == Month.getMonthNum(month)).toList();
  }
}
