import 'package:flutter/material.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/widgets/form_header_widget.dart';
import '../constants/text_strings.dart';
import 'signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormHeaderWidget(
                      image: tSignupImage,
                      title: tSignUpTitle,
                      subtitle: tSignUpSubTitle,
                    ),
                    const SignUpFormWidget(),
                    Column(
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
                          onPressed: () {},
                          child: Text.rich(
                            TextSpan(
                                text: tAlreadyHaveAnAccount,
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: const [
                                  TextSpan(
                                    text: tLogin,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }
}
