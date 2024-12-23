import 'package:flutter/material.dart';
import 'package:untitled2/features/reports/data/models/months_enum.dart';
import 'package:untitled2/features/reports/data/models/transactions_range_enum.dart';
import 'package:untitled2/features/reports/presentation/views/widgets/drop_down_menu_section.dart';

class TransactionsSummaryScreenBody extends StatefulWidget {
  const TransactionsSummaryScreenBody({super.key});

  @override
  State<TransactionsSummaryScreenBody> createState() => _TransactionsSummaryScreenBodyState();
}

class _TransactionsSummaryScreenBodyState extends State<TransactionsSummaryScreenBody> {
  late bool showAnnual;

  @override
  void initState() {
    showAnnual = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        DropDownMenuSection<String>(
          values: TransactionRange.allValues,
          onSelected: (value) {
            if (value == TransactionRange.Annual.value) {
              showAnnual = true;
            } else {
              showAnnual = false;
            }

            setState(() {});
          },
        ),
        const SizedBox(height: 15),
        if (showAnnual)
          DropDownMenuSection<int>(
            values: List.generate(DateTime.now().year - 2000 + 1, (int index) => DateTime.now().year - index),
          )
        else
          DropDownMenuSection<String>(
            values: Month.allValues,
          ),
      ],
    );
  }
}
