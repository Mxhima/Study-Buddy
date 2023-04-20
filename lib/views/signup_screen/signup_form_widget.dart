import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/controllers/signup_controller.dart';
import '../../constants/text_strings.dart';
import '../../models/user_model.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: controller.fullName,
                  decoration: const InputDecoration(
                    label: Text(tFullName),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: controller.phoneNo,
                  decoration: const InputDecoration(
                    label: Text(tPhoneNo),
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: controller.password,
                  decoration: const InputDecoration(
                    label: Text(tPassword),
                    prefixIcon: Icon(Icons.fingerprint_outlined),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // SignUpController.instance.registerUser(
                      //     controller.email.text.trim(),
                      //     controller.password.text.trim());
                      // SignUpController.instance
                      //     .phoneAuthentication(controller.phoneNo.text.trim());
                      // Get.to(() => const OTPScreen());

                      // Step - 3 [Get User and pass it to Controller.]

                      final user = UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        fullName: controller.fullName.text.trim(),
                        phoneNo: controller.fullName.text.trim(),
                      );

                      SignUpController.instance.createUser(user);
                    }
                  },
                  child: Text(tSignup.toUpperCase()),
                ),
              )
            ],
          )),
    );
  }
}
