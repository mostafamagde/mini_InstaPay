import 'package:flutter/material.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_item.dart';

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
    return Expanded(
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
    );
  }
}
