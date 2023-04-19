import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/views/otp_screen/otp_screen.dart';
import 'package:study_buddy/widgets/form_header_widget.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(
              height: 20.0 * 4,
            ),
            const FormHeaderWidget(
              image: tForgotPasswordImage,
              title: tForgetPasswordTitle,
              subtitle: tForgetPasswordSubTitle,
              crossAxisAlignment: CrossAxisAlignment.center,
              heightBetween: 20,
              textAlign: TextAlign.center,
              imageHeight: 0.32,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    hintText: tEmail,
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const OTPScreen());
                    },
                    child: const Text(tNext),
                  ),
                )
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
