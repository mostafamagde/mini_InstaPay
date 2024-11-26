import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/BankAccountManagment.dart';

import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_small_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTitleContainer(
              title: "Your Name",
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
                    Navigator.pushNamed(context, RoutesNames.AddAccountView);
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
            BankAccountManagment(),
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
               TextButton(onPressed: () {
        
               }, child:  Text("view all",style: theme.textTheme.bodyMedium?.copyWith(
                   color: theme.secondaryHeaderColor,fontWeight: FontWeight.w400
               ),),),
                SizedBox(width: 15,)
              ],
            ),
            SizedBox(height: 10 ,),
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
            SizedBox(height: 15,),
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

        
          ],
        ),
      ),
    );
  }
}
