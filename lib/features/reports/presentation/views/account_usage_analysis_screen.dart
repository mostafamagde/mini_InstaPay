import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/account_usage_analysis_screen_body.dart';

class AccountUsageAnalysisScreen extends StatelessWidget {
  const AccountUsageAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: AccountUsageAnalysisScreenBody(),
    );
  }
}
