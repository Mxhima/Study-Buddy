// ignore_for_file: deprecated_member_use, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/views/login_screen.dart';
import 'package:study_buddy/views/onboarding_screen.dart';
import 'package:study_buddy/views/signup_screen.dart';
import 'package:study_buddy/views/splash_screen.dart';
import 'package:study_buddy/views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Study buddy.',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
