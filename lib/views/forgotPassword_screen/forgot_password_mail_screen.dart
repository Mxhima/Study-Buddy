import 'package:flutter/material.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/controllers/login_controller.dart';
import 'package:study_buddy/widgets/form_header_widget.dart';

class ForgotPasswordMailScreen extends StatefulWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  State<ForgotPasswordMailScreen> createState() =>
      _ForgotPasswordMailScreenState();
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordMailScreen> {
  late String email;

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
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    hintText: tEmail,
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value.trim();
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      sendResetPasswordEmail(email);
                    },
                    child: const Text("Send"),
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
