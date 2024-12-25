import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_item.dart';

import '../../../../../core/utils/Constants.dart';
import '../../../../otp/presentation/views/otp_view.dart';
import '../../../../setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';

class UserAccountsListView extends StatelessWidget {
  const UserAccountsListView({
    super.key,
    required this.bank,
    required this.deleteAccount,
  });

  final BankAccountModel bank;
  final Future<void> Function(BankAccountModel model, int index,
      TextEditingController inputController) deleteAccount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPinCubit, ForgetPinState>(
      listener: (context, state) {
        if (state is ForgetPinSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpView(
                    userToken: state.userToken,
                    function: Constants.forgetPin),
              ));
        } if(state is ForgetPinFailure){}
      },
      builder: (context, state) {
        return Expanded(
          child: ModalProgressHUD(
            inAsyncCall: state is ForgetPinLoading,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: UserAccountsListItem(
                    index: index,
                    bank: bank,
                    deleteAccount: deleteAccount,
                  ),
                );
              },
              itemCount: bank.data?.length,
            ),
          ),
        );
      },
    );
  }
}
