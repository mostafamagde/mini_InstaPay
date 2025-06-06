import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import '../../../../../core/utils/Constants.dart';
import 'package:mini_instapay/core/utils/validation.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/core/widgets/custom_text_field.dart';
import 'package:mini_instapay/features/account_management/data/models/account_data.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/change_default_cubit/change_cubit.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/forget_pin_cubit/forget_pin_cubit.dart';

class UserAccountsListItem extends StatelessWidget {
  UserAccountsListItem({super.key, required this.banks, required this.index, required this.deleteAccount});

  final List<BankAccountData> banks;
  final int index;
  final Future<void> Function(List<BankAccountData> model, int index, TextEditingController inputController) deleteAccount;
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Container(
      width: media.width * .9,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              CachedNetworkImage(
                imageUrl: banks[index].bankId!.logo!,
                width: 50,
                height: 50,
                placeholder: (context, _) => Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryMouveColor,
                  ),
                ),
                errorWidget: (context, _, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        UserModel.instance.email!,
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      "PREPAID****${banks[index].cardNo}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: banks[index].id!),
                  );
                  snackBar(content: "Copied to ClipBoard", context: context, color: Colors.green);
                },
                icon: Icon(Icons.copy, color: Colors.grey),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                elevation: 20,
                padding: EdgeInsets.zero,
                child: const Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: '1',
                      child: const Text('See Balance'),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.pinView, arguments: banks[index].id);
                      },
                    ),
                    PopupMenuItem(
                      value: '2',
                      child: const Text('Change pin'),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.changePin, arguments: banks[index].id!);
                      },
                    ),
                    PopupMenuItem(
                        value: '3',
                        child: const Text('Delete account'),
                        onTap: () {
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
                                  pass: true,
                                  obsecure: true,
                                  inputType: TextInputType.visiblePassword,
                                  valid: Validation.validateRegularTextField,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteAccount(banks, index, inputController);
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
                        }),
                    PopupMenuItem(
                      value: '4',
                      child: Text('Change Limit'),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesNames.changeLimit, arguments: banks[index].id);
                      },
                    ),
                    PopupMenuItem(
                      value: '5',
                      child: Text('Make Default'),
                      onTap: () {
                        BlocProvider.of<ChangeDefaultAccCubit>(context).changeDefault(banks[index].id!);
                      },
                    ),
                    // PopupMenuItem(
                    //   value: '6',
                    //   child: Text('forget pin'),
                    //   onTap: () {
                    //     BlocProvider.of<ForgetPinCubit>(context).forgetPin(banks[index].id!);
                    //   },
                    // ),
                  ];
                },
              ),
              SizedBox(width: 5)
            ],
          ),
        ],
      ),
    );
  }
}
