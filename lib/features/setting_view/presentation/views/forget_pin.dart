import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/core/utils/validation.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/setting_view/presentation/manager/confirm_forget_pin/cinfirm_forget_pin_cubit.dart';



class ForgetPin extends StatelessWidget {
  final int pinLength = 6;
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final TextEditingController accId = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _onTextChanged(String value, int index, BuildContext context) {
    if (value.isNotEmpty && index < pinLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  ForgetPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userToken = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN Code'),
      ),
      body: BlocConsumer<ConfirmForgetPinCubit, ConfirmForgetPinState>(
          listener: (context, state) {
        if (state is CinfirmForgetPinFailed) {
          snackBar(content: state.errorMessage, context: context);
        } else if (state is CinfirmForgetPinSuccess) {
          snackBar(
              content: state.errorMessage,
              context: context,
              color: Colors.green);
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesNames.layoutView, (Route<dynamic> route) => false);
        }
      }, builder: (context, state) {
        final ConfirmForgetPinCubit cubit = ConfirmForgetPinCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is CinfirmForgetPinLoading,
          progressIndicator: CircularProgressIndicator(
            color: Constants.secondaryOrangeColor,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pinLength, (index) {
                    return SizedBox(
                      width: 60,
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
                              _onTextChanged(value, index, context),
                          onFieldSubmitted: (value) async {
                            if (formKey.currentState!.validate()) {
                              cubit.updatePin(
                                  controllers
                                      .map((controller) => controller.text)
                                      .join(),
                                  userToken);
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
