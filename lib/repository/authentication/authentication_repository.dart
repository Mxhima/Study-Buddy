import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:study_buddy/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/onboarding_screen/onboarding_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoro_timer_screen.dart';
import 'package:study_buddy/views/welcome_screen/welcome_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    // firebaseUser = Rx<User?>(_auth.currentUser);
    // firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    Get.to(() => const PomodoroTimer());
  }

  //Setting up the initialScreen to user who opens the app.
  // _setInitialScreen(User? user) {
  //   user ==
  //           null //user == null here means user has logged out or just pressed logout button.
  //       ? Get.offAll(() =>
  //           const WelcomeScreen()) //Get.offAll() means remove all the previous screens to user and redirect user to WelcomeScreen.
  //       : Get.offAll(() =>
  //           const HomeScreen()); //If user is not null,(user pressed login button and was authenticated) so user will be redirected to HomeScreen.
  // }

  //Phone Authentication
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The Provided phone number is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again !');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        });
  }

  //Verify OTP
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  //Register User With Email & Password
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final exc = SignUpWithEmailAndPasswordFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION - ${exc.message}");
      throw exc;
    } catch (_) {
      const exc = SignUpWithEmailAndPasswordFailure();
      print("EXCEPTION - ${exc.message}");
      throw exc;
    }
  }

  //Login User With Email & Password
  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  //Logout
  Future<void> logout() async => await _auth.signOut();
}
