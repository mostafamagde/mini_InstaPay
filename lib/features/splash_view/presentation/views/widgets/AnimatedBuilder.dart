import 'package:flutter/material.dart';

class AnimationBuilder extends StatelessWidget {
  const AnimationBuilder({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        return const Text(
          "Mini",
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic
          ),
          textAlign: TextAlign.center,
        );
      },
      animation: slidingAnimation,
    );
  }
}
