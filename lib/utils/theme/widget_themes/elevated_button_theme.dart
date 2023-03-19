import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

/* Light and Dark Elevated Button Themes */

class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances.

  /* Light Theme */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: tWhiteColor,
        backgroundColor: tPrimaryColor,
        side: const BorderSide(color: tPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16)),
  );

  /* Dark Theme */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: tWhiteColor,
        backgroundColor: tPrimaryColor,
        side: const BorderSide(color: tPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16)),
  );
}
