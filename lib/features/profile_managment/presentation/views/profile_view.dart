import 'package:flutter/material.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTitleContainer(
              title: "Profile Management",
            ),
            SizedBox(
              height: 20,
            ),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
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
