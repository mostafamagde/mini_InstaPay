import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/setting_view/presentation/manager/change_limit/change_limit_cubit.dart';

class ChangeLimit extends StatefulWidget {
  const ChangeLimit({super.key});

  @override
  State<ChangeLimit> createState() => _ChangeLimitState();
}

class _ChangeLimitState extends State<ChangeLimit> {
  String _selectedOption = "Daily"; // Initial value
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Limit"),
      ),
      body: BlocConsumer<ChangeLimitCubit, ChangeLimitState>(
        listener: (context, state) {
          if(state is ChangeLimitError){
            snackBar(content: state.message, context: context);
          }
          else if(state is ChangeLimitSuccess){
            snackBar(content: state.message, context: context,color: Colors.green);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is ChangeLimitLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  label: "Limin",
                  icon: Icons.money,
                  inputType: TextInputType.number,
                  controller: _controller,
                ),
                ListTile(
                  title: const Text("Daily"),
                  leading: Radio<String>(
                    value: "Daily",
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Weekly"),
                  leading: Radio<String>(
                    value: "Weekly",
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(onTap: () {
                  if(UserModel.getInstance().defaultAcc?.id ==null){
                    snackBar(content: "You don't have bank account", context: context);
                    return;
                  }
                  if(_controller.text.isEmpty){
                  snackBar(content: "Please enter limit", context: context);
                  }
                  BlocProvider.of<ChangeLimitCubit>(context).changeLimit(limit: double.parse(_controller.text), duration: _selectedOption.toLowerCase(), accountId: UserModel.getInstance().defaultAcc!.id!);
                }, label: "Set Limit")
              ],
            ),
          );
        },
      ),
    );
  }
}
