import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
            "Calendar",
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
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ]),
      body: SfCalendar(
        view: CalendarView.schedule,
      ),
    );
  }
}
