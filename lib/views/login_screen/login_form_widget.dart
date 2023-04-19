import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/repository/authentication/authentication_repository.dart';
import '../../constants/text_strings.dart';
import '../forgotPassword_screen/forgot_password_model_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final auth = AuthenticationRepository();
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline_outlined),
              label: Text(tEmail),
            ),
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
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.fingerprint),
              label: Text(tPassword),
              suffixIcon: IconButton(
                  onPressed: null, icon: Icon(Icons.remove_red_eye_sharp)),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ForgotPasswordScreen.buildShowModalBottomSheet(context);
              },
              child: const Text(tForgotPassword),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  // auth.loginUserWithEmailAndPassword(email, password);
                },
                child: Text(tLogin.toUpperCase())),
          ),
        ],
      ),
    ));
  }
}
