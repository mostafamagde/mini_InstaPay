import 'package:flutter/material.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/presentation/views/widgets/user_accounts_list_item.dart';

import '../../../../../core/api_helper/api_constants.dart';
import '../../../../../core/api_helper/api_manger.dart';
import '../../../../../core/utils/validation.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class UserAccountsListView extends StatelessWidget {
  const UserAccountsListView({
    super.key,
    required this.bank,
    required this.onLongPressed,
  });

  final BankAccountModel bank;
  final Future<void> Function(BankAccountModel model, int index,
      TextEditingController inputController) onLongPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onLongPress: () {
                TextEditingController inputController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(

                      title: Text(
                        "Are you sure you want to delete this account",
                      ),
                      content: CustomTextField(
                          controller: inputController,
                          label: "IPIN",
                          icon: Icons.pin,
                          inputType: TextInputType.visiblePassword,
                          valid: Validation.validateRegularTextField),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            onLongPressed(bank, index, inputController);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: UserAccountsListItem(
                index: index,
                bank: bank,
              ),
            ),
          );
        },
        itemCount: bank.data?.length,
      ),
    );
  }
}
