import 'package:untitled2/features/reports/data/models/months_enum.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';

class GetMonthlyTransactions {
  const GetMonthlyTransactions(this.transactionRepo);

  final TransactionRepository transactionRepo;

  Future<List<TransactionModel>> getMonthlyTransactions(Month month) async {
    List<TransactionModel> result = await transactionRepo.getAllTransactions();
    return result.where((TransactionModel model) => model.createdAt.month == Month.getMonthNum(month)).toList();
  }
}
