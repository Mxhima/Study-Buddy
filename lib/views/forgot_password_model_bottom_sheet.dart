import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/text_strings.dart';
import '../widgets/forgot_password_btn_widget.dart';
import 'forgot_password_mail_screen.dart';
import 'forgot_password_phone_screen.dart';

class ForgotPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tForgetPasswordTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              tForgetPasswordSubTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 30.0),
            ForgotPasswordWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: tEmail,
              subtitle: tResetViaEMail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgotPasswordMailScreen());
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            ForgotPasswordWidget(
              btnIcon: Icons.mobile_friendly_outlined,
              title: tPhoneNo,
              subtitle: tResetViaPhone,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgotPasswordPhoneScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
