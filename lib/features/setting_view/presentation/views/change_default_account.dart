import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

class ChangeDefaultAccount extends StatelessWidget {
  const ChangeDefaultAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: media.height * .2,
            child: Center(
              child: Text(
                "Paste Account Id to set as Default",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          CustomTextField(
              label: "", icon: Icons.create, inputType: TextInputType.text,valid: Validation.validateRegularTextField,),
        ],
      ),
    );
  }
}
