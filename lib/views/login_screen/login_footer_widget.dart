import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/views/signup_screen/signup_screen.dart';
import '../../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(
              image: AssetImage(tGoogleLogoImage),
              width: 20.0,
            ),
            onPressed: () {},
            label: Text(tSignInWithGoogle.toUpperCase()),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyMedium,
                children: const [
                  TextSpan(
                    text: tSignup,
                    style: TextStyle(color: Colors.blue),
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
