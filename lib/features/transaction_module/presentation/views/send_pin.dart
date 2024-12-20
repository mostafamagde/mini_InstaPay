import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/transaction_module/data/models/send_model.dart';
import 'package:untitled2/features/transaction_module/presentation/manager/send_cubit/send_cubit.dart';

class SendPin extends StatelessWidget {
  SendPin({Key? key}) : super(key: key);

  final int pinLength = 6;
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
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

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN Code'),
      ),
      body: BlocConsumer<SendCubit, SendState>(listener: (context, state) {
        if (state is SendFailed) {
          snackBar(content: state.error, context: context);
        } else if (state is SendSuccess) {
          snackBar(content: 'Money sent successfully', context: context, color: Colors.green);
        }
      }, builder: (context, state) {
        var cubit = SendCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is SendLoading,
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
                CustomTextField(
                  label: "Source account if blank Source Will be default",
                  icon: Icons.call_made_rounded,
                  inputType: TextInputType.text,
                  controller: accId,
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
                          onChanged: (value) => _onTextChanged(value, index, context),
                          onFieldSubmitted: (value) async {
                            if (formKey.currentState!.validate()) {
                              cubit.sendMoney(
                                SendModel(
                                  account: accId.text,
                                  reiceverData: data[0],
                                  pin: controllers.map((controller) => controller.text).join(),
                                  amount: int.parse(
                                    data[1],
                                  ),
                                ),
                              );
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
