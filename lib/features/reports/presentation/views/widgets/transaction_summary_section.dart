import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';

class TransactionSummarySection extends StatelessWidget {
  const TransactionSummarySection({super.key, required this.model});

  final TransactionSummaryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getRowElement('Total Send:', '${model.totalSend.toStringAsFixed(2)} EGP'),
        getRowElement('Total Receive:', '${model.totalReceive.toStringAsFixed(2)} EGP'),
        getRowElement('Send Transactions:', model.totalSendTransactions.toString()),
        getRowElement('Receive Transactions:', model.totalReceiveTransactions.toString()),
        getRowElement('Success Transactions:', model.totalSuccessTransactions.toString()),
        getRowElement('Failed Transactions:', model.totalFailedTransactions.toString()),
        getRowElement('Total Net:', '${model.totalNet.toStringAsFixed(2)} EGP'),
      ],
    );
  }

  getRowElement(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(label),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
