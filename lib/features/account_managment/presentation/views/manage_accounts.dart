import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/account_managment/data/models/account_data.dart';
import 'package:mini_instapay/features/account_managment/presentation/manager/manage_user_bank_accounts/manage_bank_accounts_cubit.dart';
import 'package:mini_instapay/features/account_managment/presentation/views/widgets/user_accounts_list_view.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/change_default_cubit/change_cubit.dart';

class ManageAccounts extends StatelessWidget {
  const ManageAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeDefaultAccCubit, ChangeState>(
      listener: (context, state) {
        if (state is ChangeFailed) {
          snackBar(content: state.message, context: context);
        } else if (state is ChangeSuccess) {
          for (BankAccountData item in UserModel.instance.bankAccounts!) {
            if (item.id == state.Id) {
              UserModel.instance.defaultAcc?.cardInfo?.cardNo = item.cardNo;
              UserModel.instance.defaultAcc?.bankId?.logo = item.bankId?.logo;
              UserModel.instance.defaultAcc?.bankId?.name = item.bankId?.name;
              UserModel.instance.defaultAcc?.id = item.id;
              break;
            }
          }
          snackBar(content: "Changed Successfully", context: context, color: Colors.green);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.layoutView,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ChangeLoading,
          child: BlocConsumer<ManageBankAccountsCubit, ManageBankAccountsState>(
            listener: (context, state) {
              if (state is ManageBankAccountsFailed) {
                snackBar(content: state.message, context: context);
              }
              if (state is ManageBankAccountsDeleteFailed) {
                snackBar(content: state.message, context: context);
              }
              if (state is ManageBankAccountsSuccess) {
                snackBar(content: state.message, context: context, color: Colors.green);
              }
            },
            builder: (context, state) {
              final ManageBankAccountsCubit cubit = ManageBankAccountsCubit.get(context);
              
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
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ),
                body: () {
                  if (state is ManageBankAccountsFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is ManageBankAccountsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ModalProgressHUD(
                      inAsyncCall: state is DeleteBancAccountLoading,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserAccountsListView(
                              deleteAccount: cubit.deleteBankAccount,
                              banks: UserModel.instance.bankAccounts!,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }.call(),
              );
            },
          ),
        );
      },
    );
  }
}
