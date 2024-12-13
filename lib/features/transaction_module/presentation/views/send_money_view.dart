import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

class SendMoneyView extends StatelessWidget {
   SendMoneyView({super.key});
  TextEditingController recieverData =TextEditingController();
  TextEditingController amount =TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTitleContainer(title: "Send Money"),
        SizedBox(
          height: media.height * .1,
        ),
        Container(
          width: media.width * .85,
          height: media.height * .25,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Send Money To",
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
                valid: Validation.validateRegularTextField,
                controller: amount ,
              ),
            ],
          ),
        ),
        Spacer(),
        CustomButton(
          onTap: () {
            Navigator.of(context).pushNamed(RoutesNames.pinSendView,arguments: [recieverData.text,amount.text]);
          },
          label: "Send",
          padding: 22,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
