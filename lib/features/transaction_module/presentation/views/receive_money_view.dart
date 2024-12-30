import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/utils/constants.dart';
import 'package:mini_instapay/core/widgets/custom_title_container.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/transaction_module/data/models/receive_model.dart';
import 'package:mini_instapay/features/transaction_module/presentation/manager/receive_cubit/receive_cubit.dart';
import 'package:mini_instapay/features/transaction_module/presentation/views/widgets/transaction_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveMoneyView extends StatelessWidget {
  ReceiveMoneyView({super.key});

  final TextEditingController recieverData = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController id = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return BlocConsumer<ReceiveCubit, ReceiveState>(listener: (context, state) {
      if (state is ReceiveSuccess) {
        snackBar(content: state.message, context: context, color: Colors.green);
      } else if (state is ReceiveFailed) {
        snackBar(content: state.errorMessage, context: context);
      }
    }, builder: (context, state) {
      final ReceiveCubit cubit = ReceiveCubit.get(context);

      return ModalProgressHUD(
        inAsyncCall: state is ReceiveLoading,
        progressIndicator: CircularProgressIndicator(
          color: Constants.secondaryOrangeColor,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTitleContainer(title: "Receive request"),
                SizedBox(
                  height: media.height * .1,
                ),
                TransactionBox(
                  title: "Receive Money",
                  amount: amount,
                  recieverData: recieverData,
                  send: false,
                  id: id,
                ),
                SizedBox(
                  height: 45.h,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      cubit.receiveMoney(
                        ReceiveModel(
                          receiveData: recieverData.text,
                          amount: int.parse(amount.text),
                          accountId: id.text,
                        ),
                      );
                    }
                  },
                  label: "Request",
                  padding: 22,
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
