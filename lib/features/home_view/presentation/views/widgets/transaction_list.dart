import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/route_generator.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/features/home_view/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text("Last Transactions"),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesNames.allTransaction);
                  },
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
          BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              if (state is TransactionSuccess) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: min(state.transactions.length, 5),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TransactionCard(
                          transaction: state.transactions[index],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              } else if (state is TransactionError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
