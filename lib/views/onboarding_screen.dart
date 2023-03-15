import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/models/onboarding_model.dart';
import 'package:study_buddy/views/onboarding_screen_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tOnboardingImage1,
          title: tOnboardingTitle1,
          subtitle: tOnboardingSubtitle1,
          counterText: tOnboardingCounter1,
          height: size.height,
          bgColor: tOnboardingPage1Color,
        ),
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tOnboardingImage2,
          title: tOnboardingTitle2,
          subtitle: tOnboardingSubtitle2,
          counterText: tOnboardingCounter2,
          height: size.height,
          bgColor: tOnboardingPage2Color,
        ),
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tOnboardingImage3,
          title: tOnboardingTitle3,
          subtitle: tOnboardingSubtitle3,
          counterText: tOnboardingCounter3,
          height: size.height,
          bgColor: tOnboardingPage3Color,
        ),
      )
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
              bottom: 60.0,
              child: OutlinedButton(
                onPressed: () {
                  int nextPage = controller.currentPage + 1;
                  controller.animateToPage(page: nextPage);
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF272727),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              )),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => controller.jumpToPage(page: 2),
              child: const Text("Skip", style: TextStyle(color: Colors.grey)),
            ),
          ),
          Positioned(
                bottom: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: Color(0xFF272727),
                    dotHeight: 5.0,
                  ),
                )),
        ],
      ),
    );
  }

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
