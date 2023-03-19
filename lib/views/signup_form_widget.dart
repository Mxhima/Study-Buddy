import 'package:flutter/material.dart';
import '../constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              decoration: const InputDecoration(
            label: Text(tFullName),
            prefixIcon: Icon(Icons.person_outline_rounded),
          )),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
              decoration: const InputDecoration(
            label: Text(tEmail),
            prefixIcon: Icon(Icons.email_outlined),
          )),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
              decoration: const InputDecoration(
            label: Text(tPhoneNo),
            prefixIcon: Icon(Icons.phone_android_outlined),
          )),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
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
              onPressed: () {},
              child: Text(tSignup.toUpperCase()),
            ),
          )
        ],
      )),
    );
  }
}
