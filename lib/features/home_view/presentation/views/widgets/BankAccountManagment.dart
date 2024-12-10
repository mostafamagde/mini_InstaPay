import 'package:flutter/material.dart';
import 'package:untitled2/core/models/user_model.dart';

import 'custom_card_button.dart';

class BankAccountManagment extends StatelessWidget {
  const BankAccountManagment({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
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
              Image.asset(
                "assets/images/banktest.jpg",
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

                  ],
                ),
              ),
              SizedBox(
                width: 22,
              ),
              IconButton(
                  onPressed: () {},
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
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: CustomAccountCardButton(
                    icon: Icons.qr_code,
                    text: "QR Code",
                  ),
                  onTap: () {},
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
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
