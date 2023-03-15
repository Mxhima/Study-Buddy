import 'package:flutter/material.dart';
import 'package:study_buddy/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFFFFAD00, <int, Color>{
      50: Color(0x1AFFAD00),
      100: Color(0x33FFAD00),
      200: Color(0x4DFFAD00),
      300: Color(0x66FFAD00),
      400: Color(0x80FFAD00),
      500: Color(0xFFFFAD00),
      600: Color(0x99FFAD00),
      700: Color(0xB3FFAD00),
      800: Color(0xCCFFAD00),
      900: Color(0xE6FFAD00),
    }),
    textTheme: TtextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0xFFFFAD00, <int, Color>{
      50: Color(0x1AFFAD00),
      100: Color(0x33FFAD00),
      200: Color(0x4DFFAD00),
      300: Color(0x66FFAD00),
      400: Color(0x80FFAD00),
      500: Color(0xFFFFAD00),
      600: Color(0x99FFAD00),
      700: Color(0xB3FFAD00),
      800: Color(0xCCFFAD00),
      900: Color(0xE6FFAD00),
    }),
    textTheme: TtextTheme.darkTextTheme,
  );
}
