import 'package:flutter/material.dart';

class AppFonts {
  static const String poppins = 'Poppins';
  static const String robotoCondensed = 'RobotoCondensed';
  static const String robotoSemiCondensed = 'RobotoSemiCondensed';
  static const String montserrat = 'Montserrat';
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.robotoCondensed,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle semiRoboto = TextStyle(
    fontFamily: AppFonts.robotoSemiCondensed,
    // fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle montserrat = TextStyle(
    fontFamily: AppFonts.montserrat,
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );
}

// This extension must be outside of any class
extension ThemeAwareTextStyle on TextStyle {
  TextStyle themed(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return copyWith(color: Colors.white);
    }
    return this;
  }
}
