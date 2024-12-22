import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/transactions_summary_screen_body.dart';

class TransactionsSummaryScreen extends StatelessWidget {
  const TransactionsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TransactionsSummaryScreenBody(),
    );
  }
}
