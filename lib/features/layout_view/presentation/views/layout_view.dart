import 'package:flutter/material.dart';
import 'package:untitled2/features/home_view/presentation/views/home_view.dart';

import '../../../profile_managment/presentation/views/profile_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  static List<Widget> screens = [
    const HomeView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (value) {
              currentIndex = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity_rounded),
                label: "Profile",
              )
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
