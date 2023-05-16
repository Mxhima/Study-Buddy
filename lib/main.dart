// ignore_for_file: deprecated_member_use, unused_import

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/controllers/meeting_provider_controller.dart';
import 'package:study_buddy/firebase_options.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/views/doNotDisturb_screen/do_not_disturb_screen.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/login_screen/login_screen.dart';
import 'package:study_buddy/views/onboarding_screen/onboarding_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoroProvider.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoroTimer_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoro_timer_screen.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest3.dart';
import 'package:study_buddy/views/profile_screen/profile_screen.dart';
import 'package:study_buddy/views/profile_screen/profile_update_screen.dart';
import 'package:study_buddy/views/signup.dart';
import 'package:study_buddy/views/signup_screen/signup_screen.dart';
import 'package:study_buddy/views/splash_screen/splash_screen.dart';
import 'package:study_buddy/views/task_screen/addTask_screen.dart';
import 'package:study_buddy/views/task_screen/taskList_screen.dart';
import 'package:study_buddy/views/welcome_screen/welcome_screen.dart';
import 'controllers/otp_controller.dart';
import 'utils/theme/theme_controller.dart';
import 'views/calendar_screen/calendar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await AudioService.init(
  //   builder: () => AudioPlayerTask(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.example.music_player.channel.audio',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MeetingProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Study buddy.',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: themeController.theme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
        home: WelcomeScreen(),
      ),
    );
  }
}
