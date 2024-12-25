import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class TransactionRepository {
  const TransactionRepository(this.apiManager);

  final ApiManager apiManager;

  Future<List<TransactionModel>> getUserTransactions() async {
    final response = await apiManager.get(ApiConstants.getTransactionEndPoint, headers: {"token": UserModel.instance.token});
    final List<dynamic> data = response.data["data"];
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final response = await apiManager.get(ApiConstants.getAllTransactionEndPoint, headers: {"token": UserModel.instance.token});
    final List<dynamic> data = response.data;
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<void> markAsSuspicious(String transactionId) async {
    await apiManager.post(ApiConstants.markAsSuspicious, {"transactionId": transactionId}, headers: {"token": UserModel.instance.token});
  }

  Future<void> requestRefund(String transactionId) async {
    await ApiManager().post(ApiConstants.requestRefund, {"transactionId": transactionId, "reason": "I want to refund the transaction"}, headers: {"token": UserModel.instance.token});
  }
}
