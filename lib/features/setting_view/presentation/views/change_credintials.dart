import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/setting_view/data/models/credinitials_model.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_credintials_cubit/change_credinitials_cubit.dart';

class ChangeCredintials extends StatelessWidget {
  ChangeCredintials({super.key});

  final TextEditingController firstNameController = TextEditingController(text: UserModel.getInstance().firstName);
  final TextEditingController lastNameController = TextEditingController(text: UserModel.getInstance().lastName);
  final TextEditingController addressController = TextEditingController(text: UserModel.getInstance().address);
  final TextEditingController phoneNumberController = TextEditingController(text: UserModel.getInstance().mobileNumber);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocConsumer<ChangeCredinitialsCubit, ChangeCredinitialsState>(
      listener: (context, state) {
        if (state is ChangeCredinitialsSuccess) {
          snackBar(content: "Changed Successfully", context: context, color: Colors.green);
          Navigator.pushNamedAndRemoveUntil(context, RoutesNames.layoutView, (route) => false,);

        } else if (state is ChangeCredinitialsFailure) {
          snackBar(content: state.errorMessage, context: context);
        }
      },
      builder: (context, state) {
        var cubit = ChangeCredinitialsCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: cubit.state is ChangeCredinitialsLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.secondaryHeaderColor,
              iconTheme: IconThemeData(color: Colors.black),
            ),
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
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.changeCredinitials(CredinitialsModel(
                                lastName: lastNameController.text,
                                firstName: firstNameController.text,
                                address: addressController.text,
                                phoneNumber: phoneNumberController.text,
                              ));
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
          ),
        );
      },
    );
  }
}
