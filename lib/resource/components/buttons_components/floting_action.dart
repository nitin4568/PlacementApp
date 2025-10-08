import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieFAB extends StatelessWidget {
  final String assetPath;
  final double size;
  final VoidCallback onPressed;

  const LottieFAB({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 150, // default size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Lottie.asset(
          assetPath,
          repeat: true,
          reverse: false,
          animate: true,
        ),
      ),
    );
  }
}
