import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/controllers/login_controller.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/musicPlayer_screen/musicdemo3.dart';
import 'package:study_buddy/views/profile_screen/profile_update_screen.dart';
import 'package:study_buddy/views/welcome_screen/welcome_screen.dart';
import 'package:study_buddy/widgets/bottom_navbar_widget.dart';
import '../../widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key});

  final themeController = Get.find<ThemeController>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    User? currentUser = _firebaseAuth.currentUser;

    // Function to fetch the user's profile data from Firebase
    Future<DocumentSnapshot> getUserProfile() {
      return _firestore.collection('Users').doc(currentUser!.uid).get();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                themeController.changeTheme(TAppTheme.lightTheme);
                themeController.saveTheme(false);
              } else {
                themeController.changeTheme(TAppTheme.darkTheme);
                themeController.saveTheme(true);
              }
            },
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while fetching data
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data!.exists) {
              var profileData = snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(tProfileImage)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileData[
                          'FullName'], // Replace 'name' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      profileData[
                          'Email'], // Replace 'email' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      profileData[
                          'PhoneNo'], // Replace 'email' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      profileData[
                          'Faculty'], // Replace 'email' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      profileData[
                          'Degree'], // Replace 'email' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      profileData[
                          'AcademicInterests'], // Replace 'email' with the field name in your Firestore collection
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => EditProfileScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                        ),
                        child: const Text(
                          tEditProfile,
                          style: TextStyle(color: tDarkColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 150),
                    //Menu
                    ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textcolor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        signOut(context);
                      },
                    ),
                  ],
                ),
              );
            }
            return Text(
                'No user data found.'); // Handle case when user data is not available
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          CustomNavItem(
            title: "Home",
            icon: LineAwesomeIcons.home,
            screen: HomeScreen(),
          ),
          CustomNavItem(
            title: "Lecturers",
            icon: LineAwesomeIcons.university,
            screen: LecturerScreen(),
          ),
          CustomNavItem(
            title: "Music",
            icon: LineAwesomeIcons.music,
            screen: MusicDemo3(),
          ),
        ],
      ),
    );
  }
}
