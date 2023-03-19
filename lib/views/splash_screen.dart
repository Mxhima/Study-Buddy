// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashController.animate.value ? 0 : -30,
              left: splashController.animate.value ? 0 : -30,
              child: const Image(image: AssetImage(tSplashTopIcon)),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: 140,
                left: splashController.animate.value ? 30 : -80,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tAppTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textDirection: TextDirection.ltr),
                      Text(tAppTagline,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textDirection: TextDirection.ltr)
                    ],
                  ),
                )),
          ),
          Obx(
            () => AnimatedPositioned(
              height: 400,
              width: 400,
              duration: const Duration(milliseconds: 2200),
              bottom: splashController.animate.value ? 150 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: const Image(
                  image: AssetImage(tSplashImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splashController.animate.value ? 60 : 0,
              right: 30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
