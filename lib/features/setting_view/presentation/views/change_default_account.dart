import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_button.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';

import '../manager/change_default_cubit/change_cubit.dart';

class ChangeDefaultAccount extends StatelessWidget {
  ChangeDefaultAccount({super.key});

  TextEditingController id = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesNames.layoutView,
                  (route) => false,
                ),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocConsumer<ChangeDefaultAccCubit, ChangeState>(
        listener: (context, state) {
          if (state is ChangeFailed) {
            snackBar(content: state.message, context: context);
          } else if (state is ChangeSuccess) {
            for (var item in UserModel.getInstance().bankAccounts!.data!) {
              if (item.id == id.text) {
                var def = UserModel.getInstance().defaultAcc;
                def?.cardInfo?.cardNo = item.cardNo;
                def?.bankId?.logo = item.bankId?.logo;
                def?.bankId?.name = item.bankId?.name;
                def?.id=item.id;
              }
            }
            snackBar(
                content: "Changed Successfully",
                context: context,
                color: Colors.green);
          }
        },
        builder: (context, state) {
          var cubit = ChangeDefaultAccCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: state is ChangeLoading,
            child: Form(
              key: formKey,
              child: Column(
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
                    label: "Default Account ID",
                    icon: Icons.create,
                    inputType: TextInputType.text,
                    valid: Validation.validateRegularTextField,
                    controller: id,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    onTap: () {
                      cubit.changeDefault(id.text);
                    },
                    label: "Change",
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
