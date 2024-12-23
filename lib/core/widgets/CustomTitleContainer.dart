import 'package:flutter/material.dart';

class CustomTitleContainer extends StatelessWidget {
  const CustomTitleContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 32),
      width: double.infinity,
      decoration: BoxDecoration(color: theme.secondaryHeaderColor),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
