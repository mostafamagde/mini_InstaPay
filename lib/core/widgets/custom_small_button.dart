import 'package:flutter/material.dart';

import '../utils/Constants.dart';

class CustomSmallButton extends StatelessWidget {
   CustomSmallButton({
    super.key,
    required this.name,
    required this.icon,
     this.onTap,
  });

  final String name;
  final IconData icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
          borderRadius: BorderRadius.circular(20),
        ),
        width: media.width * .27,
        height: media.width * .3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  color: Constants.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(22)),
              child: Icon(
                icon,
                color: theme.secondaryHeaderColor,
              ),
            ),
            SizedBox(
              height: 25,
            ),

            Text(
              name,
              maxLines: 1,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
