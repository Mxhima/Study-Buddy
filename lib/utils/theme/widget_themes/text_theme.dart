// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_buddy/constants/colors.dart';

class TtextTheme {
  TtextTheme._(); //To avoid creating instances.

  /* Light Text Theme */
  static TextTheme lightTextTheme = TextTheme(
      titleLarge: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: Colors.black87,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: Colors.black54,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: tDarkColor,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: tDarkColor,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.poppins(
        color: tDarkColor,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ));

  /* Dark Text Theme */
  static TextTheme darkTextTheme = TextTheme(
      titleLarge: GoogleFonts.montserrat(
        color: tWhiteColor,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: tWhiteColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: tWhiteColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: tWhiteColor,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: tWhiteColor,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.poppins(
        color: tWhiteColor,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ));
}
