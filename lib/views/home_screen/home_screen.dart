import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/views/calendar_screen/calendar_screen.dart';
import 'package:study_buddy/views/doNotDisturb_screen/do_not_disturb_screen.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/musicPlayer_screen/music_player.dart';
import 'package:study_buddy/views/musicPlayer_screen/musicdemo.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoroTimer_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest2.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest3.dart';
import 'package:study_buddy/views/profile_screen/profile_screen.dart';
import 'package:study_buddy/widgets/bottom_navbar_widget.dart';
import 'package:study_buddy/widgets/menu_item_widget.dart';
import '../musicPlayer_screen/musicdemo3.dart';
import 'package:study_buddy/views/task_screen/taskList_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tAppTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
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
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 35, color: tPrimaryColor),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            MenuItemWidget(
                                title: "Lecturers",
                                icon: Icons.school_rounded,
                                screen: LecturerScreen()),
                            SizedBox(
                              width: 30.0,
                            ),
                            MenuItemWidget(
                                title: "Calendar",
                                icon: Icons.calendar_month_rounded,
                                screen: CalendarScreen())
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MenuItemWidget(
                                title: "DND",
                                icon: Icons.do_disturb_on_rounded,
                                screen: DoNotDisturbScreen()),
                            const SizedBox(
                              width: 30.0,
                            ),
                            const MenuItemWidget(
                                title: "Focus",
                                icon: Icons.timer,
                                screen: pomoTest3Timer())
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MenuItemWidget(
                                title: "Home",
                                icon: Icons.home,
                                screen: HomeScreen()),
                            const SizedBox(
                              width: 30,
                            ),
                            MenuItemWidget(
                                title: "ToDo",
                                icon: Icons.task_rounded,
                                screen: TaskListScreen())
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const MenuItemWidget(
                        //         title: "Home",
                        //         icon: Icons.home,
                        //         screen: HomeScreen()),
                        //     const SizedBox(
                        //       width: 30,
                        //     ),
                        //     MenuItemWidget(
                        //         title: "ToDo",
                        //         icon: Icons.task_rounded,
                        //         screen: ToDoScreen())
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                CustomBottomNavigationBar(items: [
                  CustomNavItem(
                      title: "Home", icon: Icons.home, screen: HomeScreen()),
                  CustomNavItem(
                      title: "Lecturers",
                      icon: Icons.school,
                      screen: LecturerScreen()),
                  CustomNavItem(
                      title: "Music",
                      icon: Icons.music_note,
                      screen: MusicDemo3()),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
