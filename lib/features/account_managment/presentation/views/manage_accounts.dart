import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo_impl.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_view.dart';
import 'package:untitled2/features/auth/presentation/views/widgets/custom_text_button.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home_view/presentation/views/widgets/custom_card_button.dart';
import '../manager/get_all_user_bank_accounts/get_all_user_bank_accounts_cubit.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({super.key});

  @override
  Widget build(BuildContext context) {
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAccountsListView(

                    bank: state.bankAccounts,
                  )
                ],
              ),
            ),
            bottomNavigationBar: CusttomButton(
              onTap: () => Navigator.pushNamed(context, RoutesNames.chooseBank),
              label: "Add Account",
            ),
          );
        } else {
          return Container(
            width: 100,
            height: 100,
            color: Colors.red,
          );
        }
      },
    );
  }
}
