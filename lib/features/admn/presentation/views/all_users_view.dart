import 'package:flutter/cupertino.dart';
import 'package:untitled2/features/admn/presentation/views/widgets/user_account_list_view.dart';

class AllUsersView extends StatelessWidget {
  const AllUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    Size media =MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: media.width*.05),
      child: Column(


        children: [
          UserAccountListView()

          ]
      ),
    );
  }
}
