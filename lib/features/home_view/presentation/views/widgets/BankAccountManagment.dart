import 'package:flutter/material.dart';

import 'custom_card_button.dart';


class BankAccountManagment extends StatelessWidget {
  const BankAccountManagment({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      width: media.width * .85,
      height: media.height * .15,
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
                width: 10,
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
                    "mostafamagde227@instaPay",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    "PREPAID****1234",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(
                width: 8,
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  child: CustomAccountCardButton(
                    icon: Icons.qr_code,
                    text: "QR Code",
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 2,
                  height: 45,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
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


