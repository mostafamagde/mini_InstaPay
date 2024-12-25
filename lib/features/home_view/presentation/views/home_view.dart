import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/models/user_model.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/core/widgets/CustomTitleContainer.dart';
import 'package:mini_instapay/core/widgets/notification_icon.dart';
import 'package:mini_instapay/features/home_view/presentation/views/widgets/services_section.dart';
import 'package:mini_instapay/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:mini_instapay/features/home_view/presentation/views/widgets/BankAccountManagment.dart';
import 'package:mini_instapay/features/home_view/presentation/views/widgets/transaction_list.dart';
import 'package:mini_instapay/features/notifications/presentation/manger/notifications/notifications_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionCubit>(context).getUserTransaction();
    BlocProvider.of<NotificationsCubit>(context).getNotification();
    final user = UserModel.instance;
    final ThemeData theme = Theme.of(context);

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
                          Navigator.pushNamed(context, RoutesNames.manageAccounts);
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
                  if (user.defaultAcc != null) BankAccountManagment(),
                  if (user.defaultAcc == null)
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
                  SizedBox(height: 40),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text("Services"),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "view all",
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.secondaryHeaderColor, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 10),
                  ServicesSection(),
                  SizedBox(height: 10),
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
