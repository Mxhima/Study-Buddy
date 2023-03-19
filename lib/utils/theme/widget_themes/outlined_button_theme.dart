import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

/* Light and Dark Outlined Button Themes */

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances.

  /* Light Theme */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        foregroundColor: tSecondaryColor,
        side: const BorderSide(color: tPrimaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16)),
  );

  /* Dark Theme */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        foregroundColor: tWhiteColor,
        side: const BorderSide(color: tWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: 16)),
  );
}
