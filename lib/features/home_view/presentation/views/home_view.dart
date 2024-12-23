import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';
import 'package:untitled2/core/widgets/notification_icon.dart';
import 'package:untitled2/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/BankAccountManagment.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_list.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.onTap});

  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionCubit>(context).getUserTransaction();
    BlocProvider.of<NotificationsCubit>(context).getNotification();
    UserModel user = UserModel.getInstance();
    print(user.token);
    var theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Column(
                children: [
                  CustomTitleContainer(
                    title: '''${user.firstName![0].toUpperCase() + user.firstName!.substring(1)}
${user.lastName![0].toUpperCase() + user.lastName!.substring(1)}''',
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Accounts"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesNames.ManageAccounts);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            "Manage",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.secondaryHeaderColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (UserModel.getInstance().defaultAcc != null) BankAccountManagment(),
                  if (UserModel.getInstance().defaultAcc == null)
                    Container(
                      child: Center(
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, RoutesNames.chooseBank),
                          child: Column(
                            children: [
                              Text(
                                "Add Account",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.add,
                                color: Constants.secondaryOrangeColor,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("Services"),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "view all",
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.secondaryHeaderColor, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                    
                      children: [
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.call_made_rounded,
                            name: "Send Money",
                            onTap: () => onTap(1),
                            padding: 5,
                          ),
                        ),
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.call_received_rounded,
                            name: "Receive Money",
                            onTap: () => onTap(2),
                            padding: 5,
                          ),
                        ),
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.account_balance,
                            name: "Manage",
                            onTap: () => Navigator.pushNamed(context, RoutesNames.ManageAccounts),
                            padding: 5,
                          ),
                        )
                      ],
                    ),
                  ),
             
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                    
                      children: [
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.handshake_rounded,
                            name: "Donations",
                            padding: 5,
                          ),

                        ),
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.compare_arrows_outlined,
                            name: "Transactions",
                            onTap: () {
                              Navigator.pushNamed(context, RoutesNames.allTransaction);
                            },
                            padding: 5,
                          ),
                        ),
                        Expanded(
                          child: CustomSmallButton(
                            icon: Icons.settings,
                            name: "Settings",
                            onTap: () => onTap(3),
                            padding: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Positioned(
                top: 32,
                right: 24,
                child: NotificationIcon(),
              )
            ],
          ),
        ),
        TransactionList()
      ]),
    );
  }
}

