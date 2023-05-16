import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/musicPlayer_screen/musicdemo3.dart';
import 'package:study_buddy/widgets/bottom_navbar_widget.dart';
import 'do_not_disturb_applist_screen.dart';

class DoNotDisturbScreen extends StatefulWidget {
  DoNotDisturbScreen({super.key});

  @override
  State<DoNotDisturbScreen> createState() => _DoNotDisturbScreenState();
}

class _DoNotDisturbScreenState extends State<DoNotDisturbScreen>
    with WidgetsBindingObserver {
  final themeController = Get.find<ThemeController>();
  bool isDndEnabled = false;
  bool? _isNotificationPolicyAccessGranted = false;
  String _filterName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      updateUI();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateUI();
  }

  void updateUI() async {
    int? filter = await FlutterDnd.getCurrentInterruptionFilter();
    if (filter != null) {
      String filterName = FlutterDnd.getFilterName(filter);
      bool? isNotificationPolicyAccessGranted =
          await FlutterDnd.isNotificationPolicyAccessGranted;

      setState(
        () {
          _isNotificationPolicyAccessGranted =
              isNotificationPolicyAccessGranted;
          _filterName = filterName;
        },
      );
    }
  }

  void setInterruptionFilter(int filter) async {
    final bool? isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isNotificationPolicyAccessGranted != null &&
        isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateUI();
    }
  }

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
          "DND",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: <Widget>[
                Text("Current Filter: $_filterName"),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                    "is Notification Access Granted: ${_isNotificationPolicyAccessGranted! ? "YES" : "NO"}"),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    FlutterDnd.gotoPolicySettings();
                  },
                  child: const Text("Go To Policy Settings"),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
                  },
                  child: const Text("Turn ON DND"),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
                  },
                  child: const Text("Turn OFF DND"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setInterruptionFilter(
                        FlutterDnd.INTERRUPTION_FILTER_ALARMS);
                  },
                  child: const Text('TURN ON DND - ALLOW ALARM'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setInterruptionFilter(
                        FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
                  },
                  child: const Text('TURN ON DND - ALLOW PRIORITY'),
                ),
              ],
            ),
          ),

          // child: Switch(
          //   value: isDndEnabled,
          //   onChanged: (value) async {
          //     setState(() {
          //       isDndEnabled = value;
          //     });

          //     if (isDndEnabled) {
          //       await FlutterDnd.setInterruptionFilter(
          //           FlutterDnd.INTERRUPTION_FILTER_NONE);
          //     } else {
          //       await FlutterDnd.setInterruptionFilter(
          //           FlutterDnd.INTERRUPTION_FILTER_ALL);
          //     }
          //   },
          // ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(items: [
        CustomNavItem(title: "Home", icon: Icons.home, screen: HomeScreen()),
        CustomNavItem(
            title: "Lecturers", icon: Icons.school, screen: LecturerScreen()),
        CustomNavItem(
            title: "Music", icon: Icons.music_note, screen: MusicDemo3()),
      ]),
    );
  }
}
