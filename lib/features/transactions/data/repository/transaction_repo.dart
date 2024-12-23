import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';

class TransactionRepository {
  Future<List<TransactionModel>> getUserTransactions() async {
    final response = await ApiManager().get(ApiConstants.getTransactionEndPoint, headers: {"token": UserModel.getInstance().token});
    final List<dynamic> data = response.data["data"];
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }
  Future<List<TransactionModel>> getAllTransactions() async {
    final response = await ApiManager().get(ApiConstants.getAllTransactionEndPoint, headers: {"token": UserModel.getInstance().token});
    final List<dynamic> data = response.data;
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }
    Future<void> markAsSuspicious(String transactionId) async {
   await ApiManager().post(ApiConstants.markAsSuspicious,{
      "transactionId": transactionId
    }, headers: {"token": UserModel.getInstance().token});
  }
   Future<void> requestRefund(String transactionId) async {
   await ApiManager().post(ApiConstants.requestRefund,{
      "transactionId": transactionId,
      "reason": "I want to refund the transaction"
    }, headers: {"token": UserModel.getInstance().token});
  }
}
