import 'package:mini_instapay/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_user_model.dart';

class OneUserTransactionsModel {
  final TransactionUserModel user;
  bool iamReciever;
  final UserTransactionSummaryModel transactionSummaryModel;

  OneUserTransactionsModel({required this.iamReciever, required this.user, required this.transactionSummaryModel});

  factory OneUserTransactionsModel.init() {
    return OneUserTransactionsModel(
      iamReciever: true,
      user: TransactionUserModel.init(),
      transactionSummaryModel: UserTransactionSummaryModel.init(),
    );
  }
}
