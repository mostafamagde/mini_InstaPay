import 'package:flutter/material.dart';
import 'package:untitled2/features/account_managment/data/models/account_data.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_item.dart';

class UserAccountsListView extends StatelessWidget {
  const UserAccountsListView({super.key, required this.banks, required this.deleteAccount});

  final List<BankAccountData> banks;
  final Future<void> Function(List<BankAccountData> model, int index, TextEditingController inputController) deleteAccount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: UserAccountsListItem(
              index: index,
              banks: banks,
              deleteAccount: deleteAccount,
            ),
          );
        },
        itemCount: banks.length,
      ),
    );
  }
}
