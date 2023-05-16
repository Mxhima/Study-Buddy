import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/controllers/login_controller.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/login_screen/login_screen.dart';
import 'package:study_buddy/widgets/form_header_widget.dart';
import '../../../constants/text_strings.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _fullnameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _handleSignUp() async {
      if (_formKey.currentState!.validate()) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
          // Storing additional user info in Cloud Firestore
          FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid)
              .set({
            'FullName': _fullnameController.text,
            'Email': _emailController.text,

            // Add any other user info here that you want to store in the Firestore.
          });
          Get.offAll(() => HomeScreen());
          // Registration successful, navigate to home screen or login page
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const FormHeaderWidget(
                  image: tSignupImage,
                  title: tSignUpTitle,
                  subtitle: tSignUpSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  imageHeight: 0.25,
                ),
                const SizedBox(
                  height: 30,
                ),
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
                    onPressed: () async {
                      _handleSignUp();
                    },
                    child: Text(tSignup.toUpperCase()),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                        onPressed: () {
                          signInWithGoogle();
                        },
                        label: Text(tSignInWithGoogle.toUpperCase()),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
