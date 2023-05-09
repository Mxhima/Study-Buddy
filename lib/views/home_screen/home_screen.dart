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
import 'package:study_buddy/views/todo_screen/todo_screen.dart';

import '../musicPlayer_screen/musicdemo3.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              children: [
                Text(
                  DateTime.now().hour.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 75, color: tPrimaryColor),
                ),
                Text(
                  DateTime.now().minute.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 55, color: tPrimaryColor),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => LecturerScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Lectures"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CalendarScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Calendar"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => DoNotDisturbScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("DND"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => pomoTest3Timer());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Focus mode"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ToDoScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("To Do"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => FocusPage());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Study timer "),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => MusicPlayer());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Music Player"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              //Get.to(() => ToDoScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("To Do"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => MusicDemo3());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              color: tPrimaryColor,
                              child: Text("Music player 2 "),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
