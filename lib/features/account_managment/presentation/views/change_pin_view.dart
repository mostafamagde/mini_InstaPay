import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';

import '../manager/change_pin_cubit/change_pin_cubit.dart';

class ChangePin extends StatelessWidget {
  final int pinLength = 6;

  final List<TextEditingController> oldPinControllers =
  List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> newPinControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> oldPinFocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> newPinFocusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChangePin({Key? key}) : super(key: key);

  void _onTextChanged(String value, int index, List<FocusNode> focusNodes,
      BuildContext context) {
    if (value.isNotEmpty && index < pinLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    final cubit = ChangePinCubit.get(context);
    return BlocListener<ChangePinCubit, ChangePinState>(
      listener: (context, state) {
        if (state is ChangePinSuccess) {
          snackBar(
              content: state.message, context: context, color: Colors.green);
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesNames.layoutView, (route) => false);
        }
        if (state is ChangePinFailed) {
          snackBar(content: state.message, context: context, color: Colors.red);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: cubit.state is ChangePinLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update PIN Code',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter Old PIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPinInputRow(
                      oldPinControllers, oldPinFocusNodes, context),
                  const SizedBox(height: 40),
                  const Text(
                    'Enter New PIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPinInputRow(
                      newPinControllers, newPinFocusNodes, context),
                  const SizedBox(height: 40),
                  CustomButton(onTap: () {
                    if (formKey.currentState!.validate()) {
                      cubit.changePin(oldPinControllers.map((
                          controller) => controller.text).join(),
                          newPinControllers.map((controller) => controller.text)
                              .join(), id);
                    }
                  }, label: "Submit")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinInputRow(List<TextEditingController> controllers,
      List<FocusNode> focusNodes, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        return SizedBox(
          width: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              validator: Validation.validatePinTextField,
              controller: controllers[index],
              focusNode: focusNodes[index],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) =>
                  _onTextChanged(value, index, focusNodes, context),
            ),
          ),
        );
      }),
    );
  }
}
