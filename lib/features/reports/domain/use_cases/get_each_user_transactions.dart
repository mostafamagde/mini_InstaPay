import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/reports/data/models/one_user_transactions_model.dart';
import 'package:mini_instapay/features/reports/domain/repo_interface/one_user_transactions_repo.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';
import 'package:mini_instapay/features/transactions/data/repository/transaction_repo.dart';

class GetEachUserTransactions {
  const GetEachUserTransactions(this._transactionRepo, this._oneUserTransactionsRepo);

  final TransactionRepository _transactionRepo;
  final OneUserTransactionsRepo _oneUserTransactionsRepo;

  Future<List<OneUserTransactionsModel>> getEachUserTransactions() async {
    try {
      late List<TransactionModel> result;
      if (UserModel.instance.role == Role.admin) {
        result = await _transactionRepo.getAllTransactions();
        return _oneUserTransactionsRepo.getOneUserTransactionsForAdmin(result);
      } else {
        result = await _transactionRepo.getUserTransactions();
        return _oneUserTransactionsRepo.getOneUserTransactionsForUser(result);
      }
    } catch (_) {
      return [];
    }
  }
}
