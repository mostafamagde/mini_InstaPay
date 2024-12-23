import 'package:untitled2/features/reports/data/models/months_enum.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetMonthlyTransactions {
  const GetMonthlyTransactions(this._transactionRepo);

  final TransactionRepository _transactionRepo;

  Future<List<TransactionModel>> getMonthlyTransactions(String month, int year) async {
    List<TransactionModel> result = await _transactionRepo.getUserTransactions();
    return result.where((TransactionModel model) {
      return model.createdAt.month - 1 == Month.getMonthNum(month) && model.createdAt.year == year;
    }).toList();
  }
}
