// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/views/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -20,
              left: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tPrimaryColor,
                ),
              )),
          Positioned(
            top: 30,
            left: 75,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor,
              ),
            ),
          ),
          Positioned(
              top: 150,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tAppTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      textDirection: TextDirection.ltr),
                  Text(tAppTagline,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textDirection: TextDirection.ltr)
                ],
              )),
          Positioned(
            height: 325,
            width: 325,
            top: 250,
            left: 25,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.network(
                      "https://assets7.lottiefiles.com/packages/lf20_yjrdpceb.json",
                      controller: _controller, onLoaded: (compos) {
                    _controller
                      ..duration = compos.duration
                      ..forward().then(
                          (value) => {Get.to(() => const OnboardingScreen())});
                  }),
                ]),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
