import 'package:flutter/material.dart';

import '../../../../../core/models/user_model.dart';
import '../../../data/models/BankAccountModel.dart';

class UserAccountsListItem extends StatelessWidget {
  const UserAccountsListItem(
      {super.key, required this.bank, required this.index});

  final BankAccountModel bank;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      width: media.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          if (index == 0)
            Align(
              child: Text('    Default',style: theme.textTheme.bodySmall,),
              alignment: Alignment.centerLeft,
            ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Image.asset(
                "assets/images/banktest.jpg",
                height: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserModel.getInstance().email!,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "PREPAID****${bank.data?[index].cardNo}",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
