import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AddBankAccount(),
  ));
}

class AddBankAccount extends StatefulWidget {
  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  final List<TextEditingController> _cardNumberControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _cardNumberFocusNodes = List.generate(4, (_) => FocusNode());
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final FocusNode _cvvFocusNode = FocusNode();
  final FocusNode _expirationFocusNode = FocusNode();

  @override
  void dispose() {
    for (var controller in _cardNumberControllers) {
      controller.dispose();
    }
    for (var node in _cardNumberFocusNodes) {
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
        _cardNumberFocusNodes[index + 1].requestFocus(); // Move to the next card number field
      } else {
        _cvvFocusNode.requestFocus(); // Jump to CVV after the last card number field
      }
    }
  }

  void _onCvvChanged(String value) {
    if (value.length == 3) {
      _expirationFocusNode.requestFocus(); // Move to expiration date after entering CVV
    }
  }

  void _onExpirationChanged(String value) {
    if (value.length == 2 && !value.contains('/')) {
      // Automatically insert "/"
      _expirationController.text = "$value/";
      _expirationController.selection = TextSelection.fromPosition(
          TextPosition(offset: _expirationController.text.length));
    } else if (value.length == 5) {
      // Close keyboard when MM/YY is fully entered
      _expirationFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Entry'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card Holder Name Field
            TextField(
              controller: _cardHolderController,
              decoration: InputDecoration(
                labelText: 'Card Holder Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Card Number Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: TextField(
                      controller: _cardNumberControllers[index],
                      focusNode: _cardNumberFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      decoration: InputDecoration(
                        counterText: "", // Removes character counter
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _onCardNumberChanged(index),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            // CVV and Expiration Date in the same row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
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
                  child: TextField(
                    controller: _expirationController,
                    focusNode: _expirationFocusNode,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiration Date (MM/YY)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _onExpirationChanged,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                String cardHolderName = _cardHolderController.text;
                String cardNumber =
                _cardNumberControllers.map((controller) => controller.text).join();
                String cvv = _cvvController.text;
                String expirationDate = _expirationController.text;

                // Log or use the collected information
                print("Card Holder Name: $cardHolderName");
                print("Card Number: $cardNumber");
                print("CVV: $cvv");
                print("Expiration Date: $expirationDate");
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
