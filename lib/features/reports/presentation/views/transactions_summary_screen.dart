import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/transactions_summary_screen_body.dart';

class TransactionsSummaryScreen extends StatelessWidget {
  const TransactionsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.secondaryOrangeColor,
        title: Text('Transactions Summary', style: TextStyle(color: Colors.white, fontSize: 26)),
        centerTitle: true,
      ),
      body: const TransactionsSummaryScreenBody(),
    );
  }
}
