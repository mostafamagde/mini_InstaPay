import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';

import '../../../../core/api_helper/api_constants.dart';
import '../../../../core/api_helper/api_manger.dart';
import '../../../../core/models/user_model.dart';
import '../manager/balance_cubit/get_balance_cubit.dart';

class PinCodeScreen extends StatelessWidget {
  final int pinLength = 6;
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  PinCodeScreen({Key? key,}) : super(key: key);


  void _onTextChanged(String value, int index, BuildContext context) {
    if (value.isNotEmpty && index < pinLength - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var accountId= ModalRoute.of(context)?.settings.arguments as String;
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN Code'),
      ),
      body: BlocConsumer<GetBalanceCubit, GetBalanceState>(
        listener: (context, state) {
         if(state is GetBalanceFailed){
           snackBar(content: state.error, context: context);
         }
        },
        builder: (context, state) {
          var cubit = GetBalanceCubit.get(context);
         if(state is GetBalanceLoading){
           return Center(child:
             CircularProgressIndicator(),);
         }else if(state is GetBalanceSuccess){
          return Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Text(
                   'Available Balance',
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w500,
                     color: Colors.grey,
                   ),
                 ),
                 const SizedBox(height: 10),
                 Text(
                   '\$${state.balance.toStringAsFixed(2)}',
                   style: const TextStyle(
                     fontSize: 40,
                     fontWeight: FontWeight.bold,
                     color: Colors.green,
                   ),
                 ),
               ],
             ),
           );
         }else{
           return Form(
             key: formKey,
             child: Center(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: List.generate(pinLength, (index) {
                   return SizedBox(
                     width: 60,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
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
                             cubit.getBalance(
                                accountId,
                                 controllers
                                     .map((controller) => controller.text)
                                     .join());
                           }
                         },
                       ),
                     ),
                   );
                 }),
               ),
             ),
           );
         }
        },
      ),
    );
  }
}
