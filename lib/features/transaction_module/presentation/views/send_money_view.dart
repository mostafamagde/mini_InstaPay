import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/transaction_module/presentation/views/widgets/transaction_box.dart';

class SendMoneyView extends StatelessWidget {
   SendMoneyView({super.key});
  TextEditingController recieverData =TextEditingController();
  TextEditingController amount =TextEditingController();
   var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    Size media = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: SizedBox(
          height: media.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTitleContainer(title: "Send Money"),
              SizedBox(
                height: media.height * .1,
              ),
              TransactionBox(title: "Send Money",amount: amount,recieverData: recieverData,),
              SizedBox(
                height: 80,
              ),
              CustomButton(
                onTap: () {
                 if(formKey.currentState!.validate()){
                   Navigator.of(context).pushNamed(RoutesNames.pinSendView,arguments: [recieverData.text,amount.text]);
                 }
                },
                label: "Send",
                padding: 22,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
