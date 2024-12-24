import 'package:flutter/material.dart';
import 'package:untitled2/core/routes_manager/routes_names.dart';
import 'package:untitled2/core/widgets/custom_small_button.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomSmallButton(
                    icon: Icons.receipt_long,
                    name: "Transactions Summary",
                    padding: 5,
                    onTap: () => Navigator.pushNamed(context, RoutesNames.transactionsSummary),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomSmallButton(
                    icon: Icons.bar_chart,
                    name: "Usage Analysis",
                    padding: 5,
                    onTap: () => Navigator.pushNamed(context, RoutesNames.accountUsageAnalysis),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
