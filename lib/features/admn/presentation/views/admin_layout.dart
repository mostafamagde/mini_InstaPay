import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/admn/presentation/views/all_transactions_view.dart';
import 'package:untitled2/features/admn/presentation/views/all_users_view.dart';

import '../../../../core/navigation_cubit/navigation_cubit.dart';
import '../../../../core/utils/Constants.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        var cubit = NavigationCubit.get(context);
        final List<Widget> screens = [AllUsersView(), AllTransactionsView()];
        return Scaffold(
          appBar: AppBar(
            title: state.index == 0 ? Text("Users") : Text("Transactions"),
            centerTitle: true,
            titleTextStyle: theme.textTheme.titleLarge?.copyWith(
              fontSize: 28
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomAppBar(
              height: 90,
              color: Colors.transparent,
              padding: EdgeInsets.zero,
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Constants.backgroundColor,
                currentIndex: state.index,
                onTap: (value) {
                  cubit.selectTab(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people_outline_outlined),
                    label: "Users",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.compare_arrows_outlined),
                    label: "Transactions",
                  ),
                ],
                selectedItemColor: theme.primaryColor,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
                unselectedIconTheme: const IconThemeData(size: 22),
                selectedIconTheme: const IconThemeData(size: 28),
              ),
            ),
          ),
          body: screens[state.index],
        );
      },
    );
  }
}