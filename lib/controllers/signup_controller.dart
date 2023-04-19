import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/models/user_model.dart';
import 'package:study_buddy/repository/authentication/authentication_repository.dart';
import 'package:study_buddy/repository/user_repository/user_repository.dart';

import '../views/otp_screen/otp_screen.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from Textfields.
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  //Call this function from design and it will do the rest.
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
