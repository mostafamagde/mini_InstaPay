import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_view.dart';

import '../../../../core/models/user_model.dart';
import '../../../home_view/presentation/views/widgets/custom_card_button.dart';
import '../manager/get_all_user_bank_accounts/get_all_user_bank_accounts_cubit.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocConsumer<GetAllUserBankAccountsCubit,
        GetAllUserBankAccountsState>(
      listener: (context, state) {
        if (state is GetAllUserBankAccountsFailed) {
          snackBar(content: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is GetAllUserBankAccountsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAllUserBankAccountsSuccess) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserAccountsListView(
                  bank: state.bankAccounts,
                )
              ],
            ),
          );
        }else {
          return Container();
        }
      },
    );
  }
}
