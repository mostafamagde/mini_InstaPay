import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/home_view/data/model/transaction_model.dart';

class TransactionRepository {
  Future<List<TransactionModel>> getAllTransactions() async {
    final response = await ApiManager().get(ApiConstants.getTransactionEndPoint, headers: {"token": UserModel.getInstance().token});
    final List<dynamic> data = response.data["data"];
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }
}
