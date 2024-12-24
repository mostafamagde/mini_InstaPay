import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/transactions/data/model/user_model.dart';

class OneUserTransactionsModel {
  final User user;
  bool iamReciever;
  final TransactionSummaryModel transactionSummaryModel;

  OneUserTransactionsModel({required this.iamReciever, required this.user, required this.transactionSummaryModel});

  factory OneUserTransactionsModel.init() {
    return OneUserTransactionsModel(
      iamReciever: true,
      user: User.init(),
      transactionSummaryModel: TransactionSummaryModel.init(),
    );
  }
}
