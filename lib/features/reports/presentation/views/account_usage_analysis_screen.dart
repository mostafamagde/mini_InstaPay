import 'package:flutter/material.dart';
import 'package:mini_instapay/core/utils/Constants.dart';
import 'package:mini_instapay/features/reports/presentation/views/widgets/account_usage_analysis_screen_body.dart';

class AccountUsageAnalysisScreen extends StatelessWidget {
  const AccountUsageAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.secondaryOrangeColor,
        title: Text('Usage Analysis', style: TextStyle(color: Colors.white, fontSize: 26)),
        centerTitle: true,
      ),
      body: AccountUsageAnalysisScreenBody(),
    );
  }
}
