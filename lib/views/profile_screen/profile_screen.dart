import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/profile_screen/profile_update_screen.dart';
import '../../widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
                  //isDark ? ThemeData.dark() : ThemeData.light();

                  if (Get.isDarkMode) {
                    themeController.changeTheme(TAppTheme.lightTheme);
                    themeController.saveTheme(false);
                  } else {
                    themeController.changeTheme(TAppTheme.darkTheme);
                    themeController.saveTheme(true);
                  }
                },
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(image: AssetImage(tProfileImage))),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              tProfileHeading,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              tProfileSubheading,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const ProfileUpdateScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                  ),
                  child: const Text(
                    tEditProfile,
                    style: TextStyle(color: tDarkColor),
                  )),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            //Menu
            ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textcolor: Colors.red,
                endIcon: false,
                onPress: () {}),
          ]),
        ),
      ),
    );
  }
}
