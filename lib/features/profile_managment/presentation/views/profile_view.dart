import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: media.height*.2,
             width: double.infinity,
              decoration: BoxDecoration(color: theme.secondaryHeaderColor),
              child: Padding(


                padding: const EdgeInsets.only(top: 50,left: 15),
                child: Text('''Profile
Management''',style:theme.textTheme.titleLarge),
              ),
            ),
            SizedBox(height: 20,),
            CustomTextField(
              label: "Full Name",
              icon: Icons.person,
              inputType: TextInputType.name,
              valid: Validation.validateRegularTextField,

            ),
            SizedBox(height: 20),
            CustomTextField(
              label: "Address",
              icon: Icons.location_on,
              inputType: TextInputType.streetAddress,
              valid: Validation.validateRegularTextField,
            ),
            SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
              valid: Validation.validateEmailTextField,
            ),
            SizedBox(height: 20),
            CustomTextField(
              label: "Phone Number",
              icon: Icons.phone,
              inputType: TextInputType.phone,
              valid: Validation.validateNumberTextField,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  onPressed: () {
                    formKey.currentState!.validate();
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


