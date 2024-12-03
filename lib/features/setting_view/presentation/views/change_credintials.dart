import 'package:flutter/material.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';

import '../../../../core/utils/validation.dart';
import '../../../../core/widgets/CustomTitleContainer.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChangeCredintials extends StatelessWidget {
  ChangeCredintials({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var token =ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: SingleChildScrollView(
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
                label: "First Name",
                icon: Icons.person,
                inputType: TextInputType.name,
                valid: Validation.validateRegularTextField,
                controller: firstNameController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: "Last Name",
                icon: Icons.drive_file_rename_outline,
                inputType: TextInputType.name,
                valid: Validation.validateRegularTextField,
                controller: lastNameController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: "Address",
                icon: Icons.location_on,
                inputType: TextInputType.streetAddress,
                valid: Validation.validateRegularTextField,
                controller: addressController,
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: "Phone Number",
                icon: Icons.phone,
                inputType: TextInputType.phone,
                valid: Validation.validateNumberTextField,
                controller: phoneNumberController,
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
                    onPressed: ()  async{
                      if (formKey.currentState!.validate()) {
                        ApiManager service = ApiManager();
                       var response= await service.patch(ApiConstants.changeCredintialsEndPoint, {
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                          "mobileNumber": phoneNumberController.text,
                        },{
                          "token":token,
                         'Content-Type': 'application/x-www-form-urlencoded'
                        });

                      }
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
      ),
    );
  }
}
