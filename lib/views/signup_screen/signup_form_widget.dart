import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/controllers/login_controller.dart';
import 'package:study_buddy/controllers/signup_controller.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import '../../constants/text_strings.dart';
import '../../models/user_model.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _fullnameController = TextEditingController();
    final _phonenoController = TextEditingController();
    final AuthService _auth = AuthService();
    final DatabaseService _database = DatabaseService();

    Future<void> _handleSignUp() async {
      if (_formKey.currentState!.validate()) {
        User? user = await _auth.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text);
        if (user != null) {
          await _database.createUser(_emailController.text, user.uid);
          Get.offAll(() => const HomeScreen());
          Get.snackbar("Success", "Successfully created an account.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green);
        } else {
          Get.snackbar("Error", 'Something went wrong.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: _fullnameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text(tFullName),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: _phonenoController,
                  decoration: const InputDecoration(
                    label: Text(tPhoneNo),
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: const TextStyle(fontSize: 16),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
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
                    _handleSignUp();
                  },
                  child: Text(tSignup.toUpperCase()),
                ),
              )
            ],
          )),
    );
  }
}
