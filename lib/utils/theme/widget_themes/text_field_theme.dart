import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: tPrimaryColor,
          floatingLabelStyle: TextStyle(color: tSecondaryColor, fontSize: 18),
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: tPrimaryColor)));

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: tPrimaryColor,
          floatingLabelStyle: TextStyle(color: tPrimaryColor, fontSize: 18),
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: tPrimaryColor)));
}
