import 'package:get/get.dart';
import 'package:study_buddy/repository/authentication/authentication_repository.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomeScreen()) : Get.back();
  }
}
