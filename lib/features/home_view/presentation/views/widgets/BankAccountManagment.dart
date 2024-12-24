import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'custom_card_button.dart';

class BankAccountManagment extends StatelessWidget {
  const BankAccountManagment({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    print(UserModel.getInstance());
    return Container(
      width: media.width * .9,
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              CachedNetworkImage(
                imageUrl:
                    UserModel.getInstance().defaultAcc!.bankId?.logo ?? '',
                placeholder: (context, _) => Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryMouveColor,
                  ),
                ),
                errorWidget: (context, _, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UserModel.getInstance().email!,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "************${UserModel.getInstance().defaultAcc?.cardInfo?.cardNo!}",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 22,
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: UserModel.getInstance().email!),
                    );
                    snackBar(
                        content: "Copied to ClipBoard",
                        context: context,
                        color: Colors.green);
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Colors.grey,
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: CustomAccountCardButton(
                    icon: Icons.pin,
                    text: "Update PIN",
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.changePin,
                        arguments: UserModel.getInstance().defaultAcc?.id);
                  },
                ),
                Container(
                  width: 2,
                  height: 45,
                  color: Colors.grey,
                ),
                InkWell(
                  child: CustomAccountCardButton(
                    icon: Icons.balance,
                    text: "Check Balance",
                  ),
                  onTap: () async {
                    Navigator.pushNamed(context, RoutesNames.pinView,
                        arguments: UserModel.getInstance().defaultAcc?.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*final data = await ApiManager().post(
                          "${ApiConstants.getBalance}${UserModel.getInstance().bankAccounts!.data?[0].id}",
                          {
                            "PIN": "111111"
                          },
                          headers: {
                            "token": UserModel.getInstance().token,
                          });
                      if (data.statusCode == 201) {
                        print(data.data["data"]);
                      }*/
