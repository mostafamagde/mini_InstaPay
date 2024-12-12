import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled2/core/models/user_model.dart';
import 'package:untitled2/core/utils/Constants.dart';
import 'package:untitled2/core/widgets/custom_snackbar.dart';
import 'package:untitled2/features/otp/data/repositories/otp_factory.dart';
import 'package:untitled2/features/otp/data/repositories/otp_repo.dart';
import 'package:untitled2/features/otp/presentation/manger/cubit/otp_cubit.dart';

class OtpView extends StatefulWidget {
  final String userToken;
  final String function;

  final String? password;

  OtpView({required this.userToken, required this.function, this.password});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OtpView> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  late OtpRepository repository;
  @override
  void initState() {
    final factory = OtpFactory();
    repository = factory.createOtpRepo(widget.function, context);
    super.initState();
  }

  void _submitFunction() {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      BlocProvider.of<OtpCubit>(context)
          .submit(repository, otp, widget.userToken);
    }
  }

  void _resendOtp() {
    BlocProvider.of<OtpCubit>(context).resendOtp(repository, widget.userToken);
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

       print(UserModel.getInstance().token);
    context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
        centerTitle: true,
        backgroundColor: Constants.backgroundColor,
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if(state is OtpError){
            snackBar(content: "ewfewfewfewfewf", context: context);
          }
          else if(state is OtpResendSuccess){
            snackBar(content: "Otp Sent", context: context,color: Colors.green);
          }
        },
        builder: (context, state) {
          bool loading = state is OtpLoading;
          return ModalProgressHUD(
            inAsyncCall: loading,
            child: Padding(
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
                              if (value.isNotEmpty &&
                                  index < _otpControllers.length - 1) {
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
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _resendOtp,
                      child: Text('Resend OTP'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
