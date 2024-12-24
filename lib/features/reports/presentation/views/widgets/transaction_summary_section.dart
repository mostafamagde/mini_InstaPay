import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/reports/data/models/transaction_summary_model.dart';

class TransactionSummarySection extends StatelessWidget {
  const TransactionSummarySection({super.key, required this.model});

  final TransactionSummaryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getRowElement(
          'Total Send:',
          '${model.totalSend.toStringAsFixed(2)} EGP',
          Constants.buttonBackgroundColor,
          Icons.call_made_outlined,
          Colors.black,
        ),
        getRowElement(
          'Total Receive:',
          '${model.totalReceive.toStringAsFixed(2)} EGP',
          Constants.buttonBackgroundColor,
          Icons.call_received_rounded,
          Colors.black,
        ),
        getRowElement(
          'Send Transactions:',
          model.totalSendTransactions.toString(),
          Constants.buttonBackgroundColor,
          Icons.call_made_outlined,
          Colors.black,
        ),
        getRowElement(
          'Receive Transactions:',
          model.totalReceiveTransactions.toString(),
          Constants.buttonBackgroundColor,
          Icons.call_received_rounded,
          Colors.black,
        ),
        getRowElement(
          'Success Transactions:',
          model.totalSuccessTransactions.toString(),
          Colors.green,
          Icons.check,
          Colors.white,
        ),
        getRowElement(
          'Failed Transactions:',
          model.totalFailedTransactions.toString(),
          Colors.red,
          Icons.clear,
          Colors.white,
        ),
        getRowElement(
          'Total Net:',
          '${model.totalNet.toStringAsFixed(2)} EGP',
          Constants.buttonBackgroundColor,
          null,
          Colors.black,
        ),
      ],
    );
  }

  getRowElement(String label, String value, Color backgroundColor, IconData? icon, Color textColor) {
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
            child: Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon != null
                      ? Row(
                          children: [
                            Icon(icon, size: 18, color: textColor),
                            const SizedBox(width: 10),
                          ],
                        )
                      : SizedBox(),
                  Text(value, style: TextStyle(color: textColor)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
