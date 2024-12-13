import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/core/utils/Constants.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
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
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              CachedNetworkImage(
                imageUrl: bank.data![index].bankId!.logo!,
                width: 50,
                height: 50,
                placeholder: (context, _) => Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryMouveColor,
                  ),
                ),
                errorWidget: (context, _, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        UserModel.getInstance().email!,
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      "PREPAID****${bank.data?[index].cardNo}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: bank.data![index].id!),
                    );
                    snackBar(
                        content: "Copied to ClipBoard",
                        context: context,
                        color: Colors.green);
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.grey,
                  )),
              SizedBox(width: 5,)
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
