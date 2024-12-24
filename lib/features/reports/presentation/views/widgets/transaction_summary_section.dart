import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/models/statistics_element_model.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';
import 'package:untitled2/features/reports/data/models/user_transaction_summary_model.dart';

// ignore: must_be_immutable
class TransactionSummarySection extends StatelessWidget {
  TransactionSummarySection({super.key, required this.transactionSummaryModel});

  TransactionSummaryModel transactionSummaryModel;

  @override
  Widget build(BuildContext context) {
    List<StatisticsElementModel> models = transactionSummaryModel is AdminTransactionSummaryModel ? getAdminStatisticsModel() : getUserStatisticsModel();

    return Column(
      children: List.generate(models.length, (int index) {
        return getRowElement(models[index]);
      }),
    );
  }

  List<StatisticsElementModel> getAdminStatisticsModel() {
    final AdminTransactionSummaryModel model = transactionSummaryModel as AdminTransactionSummaryModel;

    return [
      StatisticsElementModel(
        label: 'Total Transcations Amount:',
        value: '${model.totalTransactionsAmount.toStringAsFixed(2)} EGP',
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.swap_vert,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Total Transactions:',
        value: model.totalTransactions.toString(),
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.swap_vert,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Success Transactions:',
        value: model.totalSuccessTransactions.toString(),
        backgroundColor: Colors.green,
        icon: Icons.check,
        textColor: Colors.white,
      ),
      StatisticsElementModel(
        label: 'Failed Transactions:',
        value: model.totalFailedTransactions.toString(),
        backgroundColor: Colors.red,
        icon: Icons.clear,
        textColor: Colors.white,
      ),
    ];
  }

  List<StatisticsElementModel> getUserStatisticsModel() {
    final UserTransactionSummaryModel model = transactionSummaryModel as UserTransactionSummaryModel;
    return [
      StatisticsElementModel(
        label: 'Total Send:',
        value: '${model.totalSend.toStringAsFixed(2)} EGP',
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.call_made_outlined,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Total Receive:',
        value: '${model.totalReceive.toStringAsFixed(2)} EGP',
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.call_received_rounded,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Send Transactions:',
        value: model.totalSendTransactions.toString(),
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.call_made_outlined,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Receive Transactions:',
        value: model.totalReceiveTransactions.toString(),
        backgroundColor: Constants.buttonBackgroundColor,
        icon: Icons.call_received_rounded,
        textColor: Colors.black,
      ),
      StatisticsElementModel(
        label: 'Success Transactions:',
        value: model.totalSuccessTransactions.toString(),
        backgroundColor: Colors.green,
        icon: Icons.check,
        textColor: Colors.white,
      ),
      StatisticsElementModel(
        label: 'Failed Transactions:',
        value: model.totalFailedTransactions.toString(),
        backgroundColor: Colors.red,
        icon: Icons.clear,
        textColor: Colors.white,
      ),
      StatisticsElementModel(
        label: 'Total Net:',
        value: '${model.totalNet.toStringAsFixed(2)} EGP',
        backgroundColor: Constants.buttonBackgroundColor,
        textColor: Colors.black,
      ),
    ];
  }

  Widget getRowElement(StatisticsElementModel model) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(model.label),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: model.backgroundColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  model.icon != null
                      ? Row(
                          children: [
                            Icon(model.icon, size: 18, color: model.textColor),
                            const SizedBox(width: 10),
                          ],
                        )
                      : SizedBox(),
                  Text(model.value, style: TextStyle(color: model.textColor)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
