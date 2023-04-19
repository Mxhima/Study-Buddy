// ignore_for_file: file_names, unused_import

import 'package:get/get.dart';
import 'package:study_buddy/views/onboarding_screen/onboarding_screen.dart';
import 'package:study_buddy/views/welcome_screen/welcome_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    Get.to(() => const OnboardingScreen());
  }
}
