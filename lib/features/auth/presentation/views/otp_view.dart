import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/core/api_helper/api_constants.dart';
import 'package:untitled2/core/api_helper/api_manger.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/utils/Constants.dart';

class OtpView extends StatefulWidget {
  final String userToken;
  final String function ;
  OtpView({required this.userToken, required this.function});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OtpView> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  void _submitFunction(){
    if(widget.function==Constants.signupString){
        _signUpFunction();
    }
    else if(widget.function==Constants.loginString){
        _loginFunction();
    }
    else if(widget.function==Constants.forgetPasswordString){
        _forgetPasswordFunction();
    }
  }
  void _forgetPasswordFunction()async{
  if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      final apiManager = ApiManager();
      try {
        final response = await apiManager.post(ApiConstants.forgotPasswordEndPoint, {
          "token": widget.userToken,
          "otp": int.parse(otp),
        });
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP Verified')),
          );
          Navigator.pushReplacementNamed(context, RoutesNames.loginView);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to verify OTP')),
          );
        }
      } catch (e) {
        if (e is DioException) {
          if (e.response !=null)
          print(e.response!.data["message"]);
         print("Sssssssssssssssssss ${e.message}");
        }
      }
    }
  }
  void _signUpFunction() async {
    print('otp');
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      final apiManager = ApiManager();
      try {
        final response = await apiManager.post(ApiConstants.vetifyEmailEndPoint, {
          "token": widget.userToken,
          "otp": int.parse(otp),
        });
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP Verified')),
          );
          Navigator.pushReplacementNamed(context, RoutesNames.loginView);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to verify OTP')),
          );
        }
      } catch (e) {
        if (e is DioException) {
         print("Sssssssssssssssssss ${e.message}");
        }
      }
    }
  }
  void _loginFunction() async {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      final apiManager = ApiManager();
      try {
        final response = await apiManager.post(ApiConstants.loginEndPoint, {
          "token": widget.userToken,
          "otp": int.parse(otp),
        });
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Successful')),
          );
          Navigator.pushReplacementNamed(context, RoutesNames.layoutView,arguments:widget.userToken ,);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to login')),
          );
        }
      } catch (e) {
        if (e is DioException) {
          if (e.response!=null ){
            print (e.response);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _otpControllers.length,
                  (index) => SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty && index < _otpControllers.length - 1) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFunction,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}