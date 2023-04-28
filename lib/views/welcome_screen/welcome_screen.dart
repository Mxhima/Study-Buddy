import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/views/signup_screen/signup_screen.dart';
import '../login_screen/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var brightness = MediaQuery.of(context).platformBrightness;
    //final isDark = brightness == Brightness.dark;

    return Scaffold(
      //backgroundColor: isDark ? tSecondaryColor : tWhiteColor,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage(tWelcomeImage),
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  tWelcomeTitle1,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  tWelcomesubtitle1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: Text(
                          tLogin.toUpperCase(),
                        ))),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: Text(tSignup.toUpperCase())),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
