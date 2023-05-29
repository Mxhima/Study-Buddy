import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/theme/theme_controller.dart';

class ForumNavigateScreen extends StatelessWidget {
  ForumNavigateScreen({super.key});
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
          "Forum",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        elevation: 0,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            child: Center(
              child: GestureDetector(
                onTap: () => launch("https://forum.study-buddy.me/"),
                child: SizedBox(
                  child: Text(
                    'Click Here to Open Forum',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: tPrimaryColor, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
