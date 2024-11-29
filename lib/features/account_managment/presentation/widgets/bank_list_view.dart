import 'package:flutter/cupertino.dart';

import 'banks_list_item.dart';

class BankListView extends StatelessWidget {
  const BankListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => BanksListItem(),
      itemCount: 15,
      padding: EdgeInsets.symmetric(horizontal: 20),
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
