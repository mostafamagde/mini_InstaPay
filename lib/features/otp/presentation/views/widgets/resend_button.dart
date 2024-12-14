import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ResendButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  _ResendButtonState createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  bool isDisabled = false; 
  int remainingTime = 60;  // Initial timer value in seconds
  late Timer _timer;

  void _startTimer() {
    setState(() {
      isDisabled = true;
    });
    
    // Start a countdown timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        setState(() {
          isDisabled = false;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();  // Start the timer on initialization
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
     crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isDisabled?
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'You can resend OTP in $remainingTime seconds',
              style: TextStyle(color: Colors.grey,
              fontSize: 14.sp
              ),
            ),
          ):Expanded(child: SizedBox()),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: isDisabled
                ? null 
                : () {
                    widget.onPressed();
                    _startTimer();  
                  },
            child: Text('Resend OTP'),
          ),
        ),
        
  
      ],
    );
  }
}
