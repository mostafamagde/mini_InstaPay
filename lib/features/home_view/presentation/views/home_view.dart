import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/features/home_view/presentation/views/widgets/BankAccountManagment.dart';

import '../../../../core/widgets/CustomTitleContainer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomTitleContainer(
            title: "Your Name",
          ),
          SizedBox(height: 50,),
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
          BankAccountManagment()
        ],
      ),
    );
  }
}
