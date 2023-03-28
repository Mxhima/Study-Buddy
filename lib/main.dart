// ignore_for_file: deprecated_member_use, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/firebase_options.dart';
import 'package:study_buddy/repository/authentication/authentication_repository.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/views/forgot_password_mail_screen.dart';
import 'package:study_buddy/views/home_screen.dart';
import 'package:study_buddy/views/login_screen.dart';
import 'package:study_buddy/views/onboarding_screen.dart';
import 'package:study_buddy/views/signup_screen.dart';
import 'package:study_buddy/views/splash_screen.dart';
import 'package:study_buddy/views/welcome_screen.dart';
import 'controllers/otp_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
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
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: LoginScreen(),
    );
  }
}
