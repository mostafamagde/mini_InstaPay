import 'package:flutter/material.dart';
import 'package:untitled2/features/admn/data/models/AdminUsersModel.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_item.dart';

class UserAccountListView extends StatelessWidget {
  const UserAccountListView({super.key, required this.users, required this.onPressed});

  final List<AdminUsersModel> users;
  final Future<void> Function(String id) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return UserItem(
          onPressed: onPressed,
          users: users[index],
        );
      },
      itemCount: users.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
