import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/features/home_view/presentation/views/home_view.dart';

import '../../../setting_view/presentation/views/setting_view.dart';
import '../../../transaction_module/presentation/views/receive_money_view.dart';
import '../../../transaction_module/presentation/views/send_money_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeView(),
      const SendMoneyView(),
      const ReceiveMoneyView(),
      const SettingView(),
    ];

    var theme = Theme.of(context);

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
            backgroundColor: Constants.backgroundColor,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
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
      body: screens[currentIndex],
    );
  }
}
