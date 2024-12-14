import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_view.dart';

import '../manager/manage_user_bank_accounts/manage_bank_accounts_cubit.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageBankAccountsCubit, ManageBankAccountsState>(
      listener: (context, state) {
        if (state is ManageBankAccountsFailed) {
          snackBar(content: state.message, context: context);
        }
        if (state is ManageBankAccountsDeleteFailed) {
          snackBar(content: state.message, context: context);
        }
        if (state is ManageBankAccountsSuccess) {
          snackBar(content: state.message, context: context,color: Colors.green);
        }
      },
      builder: (context, state) {
        var cubit = ManageBankAccountsCubit.get(context);
        return Scaffold(
            bottomNavigationBar: CustomButton(
              onTap: () => Navigator.pushNamed(context, RoutesNames.chooseBank),
              label: "Add Account",
            ),
            appBar: AppBar(
              leading: IconButton(

                  onPressed: () {

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesNames.layoutView,
                      (route) => false,

                    );
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            body: () {
              if (state is ManageBankAccountsFailed) {
                return Container();
              } else if (state is ManageBankAccountsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserAccountsListView(
                        onLongPressed: cubit.deleteBankAccount,
                        bank: UserModel.getInstance().bankAccounts!,
                      )
                    ],
                  ),
                );
              }
            }.call());
      },
    );
  }
}
