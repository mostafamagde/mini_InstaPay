import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/enums/otp_type.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/features/account_management/data/models/account_data.dart';
import 'package:mini_instapay/features/account_management/presentation/views/widgets/user_accounts_list_item.dart';
import 'package:mini_instapay/features/otp/presentation/views/otp_view.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';

class UserAccountsListView extends StatelessWidget {
  const UserAccountsListView({super.key, required this.banks, required this.deleteAccount});

  final List<BankAccountData> banks;
  final Future<void> Function(List<BankAccountData> model, int index, TextEditingController inputController) deleteAccount;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPinCubit, ForgetPinState>(
      listener: (context, state) {
        if (state is ForgetPinSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpView(userToken: state.userToken, type: OtpType.forgetPinOtp),
            ),
          );
        }
      },
      builder: (context, state) {
        return Expanded(
          child: ModalProgressHUD(
            inAsyncCall: state is ForgetPinLoading,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: UserAccountsListItem(
                    index: index,
                    banks: banks,
                    deleteAccount: deleteAccount,
                  ),
                );
              },
              itemCount: banks.length,
            ),
          ),
        );
      },
    );
  }
}
