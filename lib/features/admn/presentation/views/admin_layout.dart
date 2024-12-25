import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/navigation_cubit/navigation_cubit.dart';
import 'package:untitled2/core/routes_manager/route_generator.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final NavigationCubit cubit = NavigationCubit.get(context);
        final List<Widget> screens = [
          RouteGenerator.getScreen(RoutesNames.allUsersView),
          RouteGenerator.getScreen(RoutesNames.allTransaction),
          RouteGenerator.getScreen(RoutesNames.adminSetting),
        ];

        return Scaffold(
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomAppBar(
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Setting",
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
