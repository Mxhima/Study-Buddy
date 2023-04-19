import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/models/user_model.dart';
import 'package:study_buddy/repository/authentication/authentication_repository.dart';
import 'package:study_buddy/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  // Getting the User email and passing it to UserRepository to fetch user details
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateUserRecords(UserModel user) async {
    await _userRepo.updateUserDetails(user);
  }
}
