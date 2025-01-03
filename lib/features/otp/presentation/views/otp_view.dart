import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/core/enums/otp_type.dart';
import 'package:mini_instapay/core/utils/service_locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';
import 'package:mini_instapay/core/widgets/custom_snackbar.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_factory.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';
import 'package:mini_instapay/features/otp/presentation/manger/cubit/otp_cubit.dart';
import 'package:mini_instapay/features/otp/presentation/views/widgets/resend_button.dart';

class OtpView extends StatefulWidget {
  final String userToken;
  final OtpType type;

  const OtpView({super.key, required this.userToken, required this.type});

  @override
  State<OtpView> createState() => _OTPScreenState();
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
    super.initState();
    final factory = ServiceLocator.getIt<OtpFactory>();
    repository = factory.createOtpRepo(widget.type, context);
  }

  void _submitFunction() {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpControllers.map((controller) => controller.text).join();
      BlocProvider.of<OtpCubit>(context).submit(repository, otp, widget.userToken);
    }
  }

  void _resendOtp() {
    BlocProvider.of<OtpCubit>(context).resendOtp(repository, widget.userToken);
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpError) {
            snackBar(content: state.message, context: context);
          } else if (state is OtpResendSuccess) {
            snackBar(content: "Otp Sent", context: context, color: Colors.green);
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
                            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
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
                    const SizedBox(height: 8),
                    ResendButton(
                      onPressed: _resendOtp,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      onTap: _submitFunction,
                      label: "Submit",
                    ),
                    const SizedBox(height: 10),
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
