import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

class TransactionBox extends StatelessWidget {
  TransactionBox({super.key, required this.recieverData, required this.amount, required this.title, this.send = true, this.id});

  final TextEditingController recieverData;
  final TextEditingController amount;
  final TextEditingController? id;
  final String title;
  final bool send;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      width: media.width * .85,
      height: send ? media.height * .32 : media.height * .38,
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          CustomTextField(
            label: "Enter mobile number or Email",
            icon: Icons.person,
            inputType: TextInputType.text,
            valid: Validation.validateRegularTextField,
            controller: recieverData,
          ),
          CustomTextField(
            label: "Enter amount",
            icon: Icons.monetization_on,
            inputType: TextInputType.number,
            valid: Validation.validateAmountTextField,
            controller: amount,
          ),
          if (send == false)
            CustomTextField(
              label: "Optional receive account ID",
              icon: Icons.account_balance_wallet_sharp,
              inputType: TextInputType.text,
              controller: id,
            ),
        ],
      ),
    );
  }
}
