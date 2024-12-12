import 'package:flutter/material.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/BankAccountManagment.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_card.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/transaction_list.dart';
import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_small_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.getInstance();
    print(user.token);
    var theme = Theme.of(context);
    // var media = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers:[ SliverToBoxAdapter(
          child: Column(
            children: [
              CustomTitleContainer(
                title:
                    '''${user.firstName![0].toUpperCase() + user.firstName!.substring(1)}
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
              if (UserModel.getInstance().bankAccounts != null &&
                  UserModel.getInstance().bankAccounts?.data?.length != 0)
                BankAccountManagment(),
              if (UserModel.getInstance().bankAccounts == null ||
                  UserModel.getInstance().bankAccounts?.data?.length == 0)
                Container(
                  child: Center(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RoutesNames.chooseBank),
                      child: Column(
                        children: [
                          Text("Add Account",style: theme.textTheme.bodyMedium,),
                          SizedBox(height: 10,),
                          Icon(Icons.add,color: Constants.secondaryOrangeColor,size: 30,)
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
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.secondaryHeaderColor,
                          fontWeight: FontWeight.w400),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSmallButton(
                    icon: Icons.call_made_rounded,
                    name: "Send Money",
                  ),
                  CustomSmallButton(
                    icon: Icons.call_received_rounded,
                    name: "Receive Money",
                  ),
                  CustomSmallButton(
                    icon: Icons.balance,
                    name: "Bill Payment",
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSmallButton(
                    icon: Icons.handshake_rounded,
                    name: "Donations",
                  ),
                  CustomSmallButton(
                    icon: Icons.account_balance,
                    name: "Manage",
                  ),
                  CustomSmallButton(
                    icon: Icons.compare_arrows_outlined,
                    name: "Transactions",
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
             
            ],
          ),
        ),
        TransactionList()
        ]
      ),
    );
  }
}
