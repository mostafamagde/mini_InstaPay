import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/validation.dart';
import 'package:untitled2/core/widgets/CustomTitleContainer.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/core/widgets/custom_text_field.dart';
import 'package:untitled2/features/account_managment/data/models/add_account_model.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';

import '../manager/add_account/add_account_cubit.dart';

class AddBankAccount extends StatefulWidget {
  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final List<TextEditingController> _cardNumberControllers =
  List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _pinControllers =
  List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _additionalFieldControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _cardNumberFocusNodes =
  List.generate(4, (_) => FocusNode());
  final List<FocusNode> _pinFocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _additionalFieldFocusNodes =
  List.generate(4, (_) => FocusNode());
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final FocusNode _cvvFocusNode = FocusNode();
  final FocusNode _expirationFocusNode = FocusNode();

  bool _isPinVisible = false;


  @override
  void dispose() {
    for (var controller in _cardNumberControllers) {
      controller.dispose();
    }
    for (var node in _cardNumberFocusNodes) {
      node.dispose();
    }
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    for (var controller in _additionalFieldControllers) {
      controller.dispose();
    }
    for (var node in _additionalFieldFocusNodes) {
      node.dispose();
    }
    _cardHolderController.dispose();
    _cvvController.dispose();
    _expirationController.dispose();
    _cvvFocusNode.dispose();
    _expirationFocusNode.dispose();
    super.dispose();
  }

  void _onCardNumberChanged(int index) {
    if (_cardNumberControllers[index].text.length == 4) {
      if (index < 3) {
        _cardNumberFocusNodes[index + 1].requestFocus();
      } else {
        _additionalFieldFocusNodes[0].requestFocus();
      }
    }
  }

  void _onAdditionalFieldChanged(int index) {
    if (_additionalFieldControllers[index].text.length == 1) {
      if (index < 3) {
        _additionalFieldFocusNodes[index + 1].requestFocus();
      } else {
        _pinFocusNodes[0].requestFocus();
      }
    }
  }

  void _onPinChanged(int index) {
    if (_pinControllers[index].text.length == 1) {
      if (index < 5) {
        // Adjust for 6 fields
        _pinFocusNodes[index + 1].requestFocus();
      } else {
        _cvvFocusNode.requestFocus();
      }
    }
  }

  void _onCvvChanged(String value) {
    if (value.length == 3) {
      _expirationFocusNode.requestFocus();
    }
  }

  void _onExpirationChanged(String value) {
    if (value.length == 2 && !value.contains('/')) {
      _expirationController.text = "$value/";
      _expirationController.selection = TextSelection.fromPosition(
          TextPosition(offset: _expirationController.text.length));
    }
  }

  void _togglePinVisibility() {
    setState(() {
      _isPinVisible = !_isPinVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    var cubit = AddAccountCubit.get(context);
    var bank = ModalRoute
        .of(context)
        ?.settings
        .arguments as BankModel;
    var formKey = GlobalKey<FormState>();
    return BlocListener<AddAccountCubit, AddAccountState>(
      listener: (context, state) {
        if (state is AddAccountSuccess) {

          snackBar(
              content: "Added Successfully",
              context: context,
              color: Colors.green);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.ManageAccounts,
                (route) => false,
          );
        }
        if (state is AddAccountLoading) {

        }
        if (state is AddAccountFailed) {

          snackBar(content: state.errorMessage, context: context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Bank Account'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: ModalProgressHUD(
              inAsyncCall: cubit.state is AddAccountLoading,
              child: Column(
                children: [
                  CustomTitleContainer(title: "Enter card Info"),
                  CustomTextField(
                    label: 'Card Holder Name',
                    icon: Icons.person,
                    inputType: TextInputType.name,
                    valid: Validation.validateRegularTextField,
                    controller: _cardHolderController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            maxLines: 1,
                            validator: Validation.validateCardNumberTextField,
                            controller: _cardNumberControllers[index],
                            focusNode: _cardNumberFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            decoration: InputDecoration(
                              counterText: "",
                              labelText: 'Card',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _onCardNumberChanged(index),
                          ),
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPinVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: _togglePinVisibility,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            obscureText: !_isPinVisible,
                            maxLines: 1,
                            validator: Validation.validateRegularTextField,
                            controller: _additionalFieldControllers[index],
                            focusNode: _additionalFieldFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              labelText: 'CPIN',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _onAdditionalFieldChanged(index),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            maxLines: 1,
                            validator: Validation.validateRegularTextField,
                            controller: _pinControllers[index],
                            focusNode: _pinFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            obscureText: !_isPinVisible,
                            decoration: InputDecoration(
                              labelText: 'IPin',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) => _onPinChanged(index),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          maxLines: 1,
                          validator: Validation.validateCVVNumberTextField,
                          controller: _cvvController,
                          focusNode: _cvvFocusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(),
                            counterText: "",
                          ),
                          onChanged: _onCvvChanged,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          maxLines: 1,
                          validator: Validation.validateExpDateTextField,
                          controller: _expirationController,
                          focusNode: _expirationFocusNode,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'Expiration Date (MM/YY)',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: _onExpirationChanged,
                          onFieldSubmitted: (value) async {
                            if (formKey.currentState!.validate())  {
                            await  cubit.addAccount(AddAccountModel(
                                  cardNumber: _cardNumberControllers
                                      .map((controller) => controller.text)
                                      .join(),
                                  cardHolderName: _cardHolderController.text,
                                  expirationDate: _expirationController.text,
                                  cvv: _cvvController.text,
                                  pin: _pinControllers
                                      .map((controller) => controller.text)
                                      .join(),
                                  bankId: bank.id));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
