import 'package:flutter/cupertino.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_item.dart';

class AllUsersView extends StatelessWidget {
  const AllUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Row(
        children: [
         SizedBox(width: 25,), UserItem(),
        ],
      )],
    );
  }
}
