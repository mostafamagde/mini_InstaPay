import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/home_view/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionSuccess) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Text("Last Transactions"),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "view all",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.secondaryHeaderColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), 
                  shrinkWrap: true, 
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TransactionCard(transaction: state.transactions[index],),
                        if (index < state.transactions.length - 1)
                          const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is TransactionError) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text("Last Transactions"),
                ),
                SizedBox(height: 16,),
                Center(
                  child: Text(state.error),
                ),
              ],
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text("Last Transactions"),
                ),
                const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }
      },
    );
  }
}
