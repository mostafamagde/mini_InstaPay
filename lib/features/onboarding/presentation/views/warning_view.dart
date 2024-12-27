import 'package:flutter/material.dart';
import 'package:mini_instapay/core/routes_manager/routes_names.dart';
import 'package:mini_instapay/core/widgets/custom_button.dart';

class WarningView extends StatelessWidget {
  const WarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 96),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'This application is a student project and is not intended for real-world use.',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextSpan(
                        text: 'Please do not share your banking information or any sensitive data.',
                        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'هذا التطبيق هو مشروع طلابي وهو غير مخصص للاستخدام الفعلي',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextSpan(
                        text: '. يرجى عدم مشاركة معلوماتك البنكية أو أي بيانات حساسة.',
                        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
            CustomButton(
              onTap: () => Navigator.of(context).pushReplacementNamed(RoutesNames.onBoarding),
              label: 'Ok',
            ),
          ],
        ),
      ),
    );
  }
}
