import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/admn/presentation/views/all_users_view.dart';
import 'package:untitled2/features/notifications/data/repository/notifications_repo.dart';
import 'package:untitled2/features/notifications/presentation/manger/notifications/notifications_cubit.dart';
import 'package:untitled2/features/transactions/data/repository/transaction_repo.dart';
import 'package:untitled2/features/transactions/presentation/manger/cubit/transaction_cubit.dart';
import 'package:untitled2/features/transactions/presentation/views/all_transaction_view.dart';

import '../../../../core/navigation_cubit/navigation_cubit.dart';
import '../../../../core/utils/Constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../setting_view/data/repos/setting_repo_impl.dart';
import '../../../setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import '../../data/repo/admin_repo_impl.dart';
import '../manager/ban_users_cubit/ban_users_cubit.dart';
import '../manager/get_users_cubit/admin_get_users_cubit.dart';
import 'admin_setting.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        var cubit = NavigationCubit.get(context);
        final List<Widget> screens = [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AdminGetUsersCubit(
                  AdminRepoImpl(),
                )..getAllUsers(),
              ),
              BlocProvider(
                create: (context) => BanUsersCubit(
                  AdminRepoImpl(),
                ),
              ),

            ],
            child: AllUsersView(),
          ),
          MultiBlocProvider(
            providers: [
                   BlocProvider(
          create: (context) => TransactionCubit(TransactionRepository())),
                  BlocProvider(
          create: (context) => NotificationsCubit(NotificationsRepo())),
            ],
            child: AllTransactionView(),
          ),
          BlocProvider(
            create: (context) => LogOutCubit(
              ServiceLocator.getIt.get<SettingRepoImpl>(),
            ),
            child: AdminSetting(),
          )

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
