import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topRight,
      children:[
        Container(
          height: media.height * .18,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/InstaLogo.png"),
            ),
          ),

        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Skip to Home",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ]
    );
  }
}
