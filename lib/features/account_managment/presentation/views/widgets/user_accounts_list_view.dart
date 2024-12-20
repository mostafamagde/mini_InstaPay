import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
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
            padding: const EdgeInsets.only(top: 15),
            child: Slidable(
              startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  extentRatio: .28,
                  children: [
                    SlidableAction(
                      padding: EdgeInsets.only(right: 10),
                      backgroundColor: Constants.backgroundColor,
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                      onPressed: (BuildContext context) {
                        {
                          TextEditingController inputController =
                              TextEditingController();

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
                                      Navigator.of(context)
                                          .pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteAccount(
                                          bank, index, inputController);
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
                        }
                      },
                    ),
                    SlidableAction(
                      padding: EdgeInsets.only(right: 15),
                      backgroundColor: Constants.backgroundColor,
                      foregroundColor: Colors.grey,
                      icon: Icons.balance,
                      onPressed: (BuildContext context) {
                        Navigator.pushNamed(context, RoutesNames.pinView, arguments: bank.data?[index].id);

                      },
                    ),
                  ]),
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
