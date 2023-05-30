import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/calendar_screen/calendar_screen.dart';
import 'package:study_buddy/views/doNotDisturb_screen/do_not_disturb_screen.dart';
import 'package:study_buddy/views/forum_screen/forumView.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoroTimer_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest2.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest3.dart';
import 'package:study_buddy/views/profile_screen/profile_screen.dart';
import 'package:study_buddy/widgets/bottom_navbar_widget.dart';
import 'package:study_buddy/widgets/menu_item_widget.dart';
import '../musicPlayer_screen/musicdemo3.dart';
import 'package:study_buddy/views/task_screen/taskList_screen.dart';

import '../relaxation_screen/relaxation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController = Get.find<ThemeController>();
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tAppTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                themeController.changeTheme(TAppTheme.lightTheme);
                themeController.saveTheme(false);
              } else {
                themeController.changeTheme(TAppTheme.darkTheme);
                themeController.saveTheme(true);
              }
            },
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tCardBgColor),
            child: IconButton(
              onPressed: () => Get.to(() => ProfileScreen()),
              icon: const Image(
                image: AssetImage(tUserProfileImage),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 45, color: tPrimaryColor),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              MenuItemWidget(
                                  title: "Lecturers",
                                  icon: (LineAwesomeIcons.university),
                                  screen: LecturerScreen()),
                              SizedBox(
                                width: 30.0,
                              ),
                              MenuItemWidget(
                                  title: "Calendar",
                                  icon: (LineAwesomeIcons
                                      .calendar_with_day_focus),
                                  screen: CalendarScreen())
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MenuItemWidget(
                                  title: "DND",
                                  icon: (LineAwesomeIcons.exclamation_circle),
                                  screen: DoNotDisturbScreen()),
                              const SizedBox(
                                width: 30.0,
                              ),
                              const MenuItemWidget(
                                  title: "Focus",
                                  icon: (LineAwesomeIcons.hourglass_start),
                                  screen: pomoTest3Timer())
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const MenuItemWidget(
                                  title: "Relaxation",
                                  icon: (LineAwesomeIcons.couch),
                                  screen: RelaxationScreen()),
                              const SizedBox(
                                width: 30,
                              ),
                              MenuItemWidget(
                                  title: "ToDo",
                                  icon: (LineAwesomeIcons.tasks),
                                  screen: TaskListScreen())
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MenuItemWidget(
                                  title: "Forum",
                                  icon: (LineAwesomeIcons.discourse),
                                  screen: ForumNavigateScreen()),
                              const SizedBox(
                                width: 30,
                              ),
                              MenuItemWidget(
                                  title: "ToDo",
                                  icon: Icons.task_rounded,
                                  screen: TaskListScreen())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomBottomNavigationBar(
                  items: [
                    CustomNavItem(
                        title: "Home",
                        icon: (LineAwesomeIcons.home),
                        screen: HomeScreen()),
                    CustomNavItem(
                        title: "Lecturers",
                        icon: (LineAwesomeIcons.university),
                        screen: LecturerScreen()),
                    CustomNavItem(
                        title: "Music",
                        icon: (LineAwesomeIcons.music),
                        screen: MusicDemo3()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
