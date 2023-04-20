import 'package:flutter/material.dart';
import 'login_footer_widget.dart';
import 'login_form_widget.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //var brightness = MediaQuery.of(context).platformBrightness;
    //final isDark = brightness == Brightness.dark;

    return SafeArea(
        child: Scaffold(
      //backgroundColor: isDark ? tSecondaryColor : tWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeaderWidget(size: size),
              const LoginForm(),
              const LoginFooterWidget()
            ],
          ),
        ),
      ),
    ));
  }
}
