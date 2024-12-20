import 'package:flutter/material.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/transaction_item.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionItem();
        },
        itemCount: 20,
      ),
    );
  }
}
