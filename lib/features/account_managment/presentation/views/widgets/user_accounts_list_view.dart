import 'package:flutter/material.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_item.dart';

class UserAccountsListView extends StatelessWidget {
  const UserAccountsListView({super.key, required this.bank});

  final List<BankAccountModel> bank;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return UserAccountsListItem(
            index: index,
            bank: bank[index],
          );
        },
        itemCount: bank.length,
      ),
    );
  }
}
