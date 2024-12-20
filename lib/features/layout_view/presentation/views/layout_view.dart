import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/navigation_cubit/navigation_cubit.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/service_locator.dart';
import 'package:untitled2/features/home_view/presentation/views/home_view.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo_impl.dart';
import 'package:untitled2/features/setting_view/presentation/manager/log_out_cubit/log_out_cubit.dart';
import 'package:untitled2/features/setting_view/presentation/views/setting_view.dart';
import 'package:untitled2/features/transaction_module/data/repos/transaction_repo_impl.dart';
import 'package:untitled2/features/transaction_module/presentation/manager/receive_cubit/receive_cubit.dart';
import 'package:untitled2/features/transaction_module/presentation/views/receive_money_view.dart';
import 'package:untitled2/features/transaction_module/presentation/views/send_money_view.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        var cubit = NavigationCubit.get(context);
        final List<Widget> screens = [
          HomeView(
            onTap: cubit.selectTab,
          ),
          SendMoneyView(),
          BlocProvider(
            create: (context) => ReceiveCubit(
              ServiceLocator.getIt.get<TransactionRepoImpl>(),
            ),
            child: ReceiveMoneyView(),
          ),
          BlocProvider(
            create: (context) => LogOutCubit(ServiceLocator.getIt.get<SettingRepoImpl>()),
            child: SettingView(),
          ),
        ];
        return Scaffold(
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
                    icon: Icon(Icons.home_outlined),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.call_made_outlined),
                    label: "Send",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.call_received_rounded),
                    label: "Receive",
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
