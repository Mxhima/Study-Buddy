import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/models/onboarding_model.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/onboarding_screen/onboarding_screen_widget.dart';
import 'package:study_buddy/views/welcome_screen/welcome_screen.dart';

class RelaxationScreen extends StatefulWidget {
  const RelaxationScreen({super.key});

  @override
  State<RelaxationScreen> createState() => _RelaxationScreenState();
}

class _RelaxationScreenState extends State<RelaxationScreen> {
  final controller = LiquidController();

  //This helps us to change the animated smooth indicator to be changed when a page is changed.
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pages = [
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tRelaxationImage1,
          title: tRelaxationTitle1,
          subtitle: tRelaxationSubtitle1,
          counterText: tRelaxationCounter1,
          height: size.height,
          bgColor: tOnboardingPage1Color,
        ),

//This widget is used to simplify the codebase by using code reusability.
//We can add any number of pages by calling this widget and feeding the
//required parameters.
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tRelaxationImage2,
          title: tRelaxationTitle2,
          subtitle: tRelaxationSubtitle2,
          counterText: tRelaxationCounter2,
          height: size.height,
          bgColor: tOnboardingPage2Color,
        ),
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tRelaxationImage3,
          title: tRelaxationTitle3,
          subtitle: tRelaxationSubtitle3,
          counterText: tRelaxationCounter3,
          height: size.height,
          bgColor: tOnboardingPage3Color,
        ),
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tRelaxationImage4,
          title: tRelaxationTitle4,
          subtitle: tRelaxationSubtitle4,
          counterText: tRelaxationCounter4,
          height: size.height,
          bgColor: tOnboardingPage1Color,
        ),
      ),
      OnBoardingScreenWidget(
        model: OnBoardingModel(
          image: tRelaxationImage5,
          title: tRelaxationTitle5,
          subtitle: tRelaxationSubtitle5,
          counterText: tRelaxationCounter5,
          height: size.height,
          bgColor: tOnboardingPage2Color,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center, //all the elements will be in the center.
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => Get.to(() => const HomeScreen()),
              child: const Text("Skip", style: TextStyle(color: Colors.grey)),
            ),
          ),
          Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                activeIndex: controller
                    .currentPage, //this gets the active index of the liquid swipe.
                count: 5,
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
    //When the page is going to be changed we want the Animated smooth indicator to change accordingly.
  }
}
