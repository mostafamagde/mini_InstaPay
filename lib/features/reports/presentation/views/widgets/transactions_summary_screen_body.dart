import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/enums/role_enum.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/reports/data/enums/months_enum.dart';
import 'package:mini_instapay/features/reports/data/enums/transactions_range_enum.dart';
import 'package:mini_instapay/features/reports/data/models/admin_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/data/models/transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/data/models/user_transaction_summary_model.dart';
import 'package:mini_instapay/features/reports/presentation/manager/transaction_summary_view_cubit/transaction_summary_view_cubit.dart';
import 'package:mini_instapay/features/reports/presentation/views/widgets/drop_down_menu_section.dart';
import 'package:mini_instapay/features/reports/presentation/views/widgets/transaction_summary_section.dart';

class TransactionsSummaryScreenBody extends StatelessWidget {
  const TransactionsSummaryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionSummaryViewCubit cubit = BlocProvider.of<TransactionSummaryViewCubit>(context);
    late TransactionSummaryModel transactionSummaryModel = UserModel.instance.role == Role.admin ? AdminTransactionSummaryModel.init() : UserTransactionSummaryModel.init();
    final String initMonth = Month.values[DateTime.now().month - 1].value;
    final int initYear = DateTime.now().year;
    String month = initMonth;
    int year = initYear;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async => await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(year),
    );

    return BlocConsumer<TransactionSummaryViewCubit, TransactionSummaryViewState>(
      listener: (context, state) {
        if (state is TransactionSummaryViewLoading) {
          transactionSummaryModel = UserModel.instance.role == Role.admin ? AdminTransactionSummaryModel.init() : UserTransactionSummaryModel.init();
        }
        if (state is TransactionSummaryViewSuccess) {
          transactionSummaryModel = state.transactionSummaryModel;
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
                    if (value == TransactionRange.monthly.value) {
                      cubit.showMonth = true;
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(month, year);
                    } else {
                      cubit.showMonth = false;
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(year);
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
                    year = value!;
                    if (cubit.showMonth) {
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(month, year);
                    } else {
                      await BlocProvider.of<TransactionSummaryViewCubit>(context).getAnnualTransactions(year);
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
                        month = value!;
                        await BlocProvider.of<TransactionSummaryViewCubit>(context).getMonthlyTransactions(month, year);
                      },
                    ),
                  ],
                ),
              SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TransactionSummarySection(transactionSummaryModel: transactionSummaryModel),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        );
      },
    );
  }
}
