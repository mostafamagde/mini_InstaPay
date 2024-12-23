import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/reports/data/models/months_enum.dart';
import 'package:untitled2/features/reports/data/models/transactions_range_enum.dart';
import 'package:untitled2/features/reports/presentation/manager/transaction_summary_view_cubit/transaction_summary_view_cubit.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/drop_down_menu_section.dart';
import 'package:untitled2/features/transactions/data/model/transaction_model.dart';
import 'package:untitled2/features/transactions/presentation/views/widgets/transaction_card.dart';

class TransactionsSummaryScreenBody extends StatelessWidget {
  const TransactionsSummaryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionSummaryViewCubit cubit = BlocProvider.of<TransactionSummaryViewCubit>(context);
    late List<TransactionModel> transactionModels = [];
    final String initMonth = Month.values[DateTime.now().month - 1].value;
    final int initYear = DateTime.now().year;
    String monthlyRangeMonth = initMonth;
    int monthlyRangeYear = initYear;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async => await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(initYear),
    );

    return BlocConsumer<TransactionSummaryViewCubit, TransactionSummaryViewState>(
      listener: (context, state) {
        if (state is TransactionSummaryViewLoading) {
          transactionModels = [];
        } else if (state is TransactionSummaryViewSuccess) {
          transactionModels = state.transactions;
        } else if (state is TransactionSummaryViewFailed) {
          snackBar(content: "Something went wrong", context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is TransactionSummaryViewLoading,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: DropDownMenuSection<String>(
                  initialSelection: TransactionRange.values[0].value,
                  values: TransactionRange.allValues,
                  onSelected: (value) async {
                    if (value == TransactionRange.Monthly.value) {
                      cubit.showMonth = true;
                      monthlyRangeMonth = initMonth;
                      monthlyRangeYear = initYear;
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(initMonth, initYear);
                    } else {
                      cubit.showMonth = false;
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(initYear);
                    }
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
              SliverToBoxAdapter(
                child: DropDownMenuSection<int>(
                  initialSelection: initYear,
                  values: List.generate(DateTime.now().year - 2000 + 1, (int index) => DateTime.now().year - index),
                  onSelected: (value) async {
                    if (cubit.showMonth) {
                      monthlyRangeYear = value!;
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(monthlyRangeMonth, monthlyRangeYear);
                    } else {
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(value!);
                    }
                  },
                ),
              ),
              if (cubit.showMonth)
                SliverList.list(
                  children: [
                    SizedBox(height: 15),
                    DropDownMenuSection<String>(
                      initialSelection: initMonth,
                      values: Month.allValues,
                      onSelected: (value) async {
                        monthlyRangeMonth = value!;
                        await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(monthlyRangeMonth, monthlyRangeYear);
                      },
                    ),
                  ],
                ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: transactionModels.length,
                  (context, index) {
                    return TransactionCard(transaction: transactionModels[index]);
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15)),
            ],
          ),
        );
      },
    );
  }
}
