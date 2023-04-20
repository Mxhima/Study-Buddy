import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_buddy/controllers/login_controller.dart';
import 'package:study_buddy/views/forgotPassword_screen/forgot_password_mail_screen.dart';
import '../../constants/text_strings.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  late String email, password;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = AuthenticationRepository();
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              label: Text(tEmail),
            ),
            onChanged: (value) {
              setState(() {
                email = value.trim();
              });
            },
            // validator: (value) {
            //   if (value!.isEmpty || !value.contains('@')) {
            //     return "Incorrect Email";
            //   } else {
            //     return null;
            //   }
            // },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _controller,
            obscureText: _obscureText,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.fingerprint),
              label: const Text(tPassword),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                password = value.trim();
              });
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.to(() => const ForgotPasswordMailScreen());
              },
              child: const Text(tForgotPassword),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  signInWithEmail(email, password);
                },
                child: Text(tLogin.toUpperCase())),
          ),
        ],
      ),
    ));
  }
}
