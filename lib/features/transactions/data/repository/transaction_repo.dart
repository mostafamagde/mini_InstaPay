import 'package:mini_instapay/core/api_helper/api_constants.dart';
import 'package:mini_instapay/core/api_helper/api_manger.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';

class TransactionRepository {
  const TransactionRepository(this._apiManager);

  final ApiManager _apiManager;

  Future<List<TransactionModel>> getUserTransactions() async {
    final response = await _apiManager.get(ApiConstants.getTransactionEndPoint, headers: {"token": UserModel.instance.token});
    final List<dynamic> data = response.data["data"];
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final response = await _apiManager.get(ApiConstants.getAllTransactionEndPoint, headers: {"token": UserModel.instance.token});
    final List<dynamic> data = response.data;
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<void> markAsSuspicious(String transactionId) async {
    await _apiManager.post(ApiConstants.markAsSuspicious, {"transactionId": transactionId}, headers: {"token": UserModel.instance.token});
  }

  Future<void> requestRefund(String transactionId) async {
    await _apiManager.post(ApiConstants.requestRefund, {"transactionId": transactionId, "reason": "I want to refund the transaction"}, headers: {"token": UserModel.instance.token});
  }
}
