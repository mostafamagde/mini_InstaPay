import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_view.dart';
import '../manager/get_all_user_bank_accounts/manage_bank_accounts_cubit.dart';

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
      },
      builder: (context, state) {
        var cubit = ManageBankAccountsCubit.get(context);
        if (state is ManageBankAccountsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ManageBankAccountsSuccess) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAccountsListView(
                    onLongPressed: cubit.deleteBankAccount,
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
        }else if(state is ManageBankAccountsLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          return Text("Something went wrong"); 
        }
      },
    );
  }
}
