import 'package:flutter/material.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_item.dart';

import '../../../data/models/AdminUsersModel.dart';

class UserAccountListView extends StatelessWidget {
  const UserAccountListView({super.key, required this.users});
  final List<AdminUsersModel> users;

  @override
  Widget build(BuildContext context) {
    print(users.length);
    return ListView.builder(
      itemBuilder: (context, index) {

        return UserItem(users: users[index],);
      },
      itemCount: users.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
