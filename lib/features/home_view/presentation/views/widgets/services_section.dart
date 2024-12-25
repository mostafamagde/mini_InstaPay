import 'package:flutter/material.dart';
import 'package:untitled2/core/navigation_cubit/navigation_cubit.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationCubit cubit = NavigationCubit.get(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.call_made_rounded,
                  name: "Send Money",
                  padding: 5,
                  onTap: () => cubit.selectTab(1),
                ),
              ),
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.call_received_rounded,
                  name: "Receive Money",
                  padding: 5,
                  onTap: () => cubit.selectTab(2),
                ),
              ),
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.account_balance,
                  name: "Manage",
                  padding: 5,
                  onTap: () => Navigator.pushNamed(context, RoutesNames.ManageAccounts),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.analytics_sharp,
                  name: "Analytics",
                  padding: 5,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.analyticsView);
                  },
                ),
              ),
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.compare_arrows_outlined,
                  name: "Transactions",
                  padding: 5,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.allTransaction);
                  },
                ),
              ),
              Expanded(
                child: CustomSmallButton(
                  icon: Icons.settings,
                  name: "Settings",
                  padding: 5,
                  onTap: () => cubit.selectTab(3),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
