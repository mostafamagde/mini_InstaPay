import 'package:flutter/material.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_item.dart';

class UserAccountListView extends StatelessWidget {
  const UserAccountListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      itemBuilder: (context, index) {
        return UserItem();
      },itemCount: 20,padding: EdgeInsets.symmetric(vertical: 10),
    ),);
  }
}
