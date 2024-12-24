import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/reports/data/models/one_user_transactions_model.dart';
import 'package:untitled2/features/reports/presentation/manager/usage_analysis_cubit/usage_analysis_cubit.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/drop_down_menu_section.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/transaction_summary_section.dart';

class AccountUsageAnalysisScreenBody extends StatelessWidget {
  const AccountUsageAnalysisScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final UsageAnalysisCubit cubit = BlocProvider.of<UsageAnalysisCubit>(context);
    List<OneUserTransactionsModel> models = [];
    OneUserTransactionsModel showedModel = OneUserTransactionsModel.init();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async => await cubit.getEachUserTransactions(),
    );

    return BlocConsumer<UsageAnalysisCubit, UsageAnalysisState>(
      listener: (context, state) {
        if (state is UsageAnalysisLoading) {
          models = [];
          showedModel = OneUserTransactionsModel.init();
        }
        if (state is UsageAnalysisSuccess) {
          models = state.oneUserTransactionsModels;
          showedModel = state.showedModel;
        } else if (state is UsageAnalysisFailed) {
          snackBar(content: "Something went wrong", context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UsageAnalysisLoading,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              if (models.isNotEmpty)
                SliverToBoxAdapter(
                  child: DropDownMenuSection<String>(
                    initialSelection: models.first.user.id,
                    values: List.generate(models.length, (int index) => models[index].user.id),
                    labels: List.generate(models.length, (int index) => models[index].user.userName),
                    onSelected: (value) {
                      showedModel = models.firstWhere(
                        (OneUserTransactionsModel element) {
                          return element.user.id == value;
                        },
                      );
                      cubit.refresh(models, showedModel);
                    },
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TransactionSummarySection(model: showedModel.transactionSummaryModel),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
