import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/controllers/calendar_meeting_datasource_controller.dart';
import 'package:study_buddy/controllers/meeting_provider_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import '../../models/calendar_meeting_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final themeController = Get.find<ThemeController>();

  //List<Meeting> _getDataSource() {
  // final List<Meeting> meetings = <Meeting>[];
  // final DateTime today = DateTime.now();
  // final DateTime startTime =
  //     DateTime(today.year, today.month, today.day, 9, 0, 0);
  // final DateTime endTime = startTime.add(const Duration(hours: 2));
  // meetings
  //     .add(Meeting('conference', startTime, endTime, Colors.green, false));
  // meetings.add(Meeting('conference1', startTime.add(const Duration(hours: 3)),
  //     endTime.add(const Duration(hours: 2)), Colors.blue, false));
  // return meetings;
  //}

  // CalendarView calendarView = CalendarView.month;
  // CalendarController calController = CalendarController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  late final FirebaseFirestore firestore;
  late CalendarController calController;
  late final User user;

  @override
  void initState() {
    super.initState();

    user = auth.currentUser!;
    firestore = FirebaseFirestore.instance;
    calController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final provider = Provider.of<MeetingProvider>(context);

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
                  //deleteAppointment();
                },
                icon: const Icon(LineAwesomeIcons.trash)),
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Expanded(
              //   child: OutlinedButton(
              //       style: const ButtonStyle(),
              //       onPressed: () {
              //         setState(() {
              //           calendarView = CalendarView.month;
              //           calController.view = calendarView;
              //         });
              //       },
              //       child: const Text("Month View")),
              // ),
              // Expanded(
              //   child: OutlinedButton(
              //       onPressed: () {
              //         setState(() {
              //           calendarView = CalendarView.week;
              //           calController.view = calendarView;
              //         });
              //       },
              //       child: const Text("Week View")),
              // ),
              // Expanded(
              //   child: OutlinedButton(
              //       onPressed: () {
              //         setState(() {
              //           calendarView = CalendarView.schedule;
              //           calController.view = calendarView;
              //         });
              //       },
              //       child: const Text("Schedule View")),
              // ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              //   view: calendarView,
              //   initialSelectedDate: DateTime.now(),
              //   controller: calController,
              //   cellBorderColor: tPrimaryColor,
              //   dataSource: MeetingDataSource(provider.meetings),
              //   selectionDecoration: BoxDecoration(
              //       border: Border.all(color: tPrimaryColor, width: 2),
              //       borderRadius: const BorderRadius.only(
              //           topLeft: Radius.circular(5),
              //           topRight: Radius.zero,
              //           bottomLeft: Radius.zero,
              //           bottomRight: Radius.circular(5)),
              //       shape: BoxShape.rectangle),
              //   monthViewSettings: const MonthViewSettings(
              //       appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              //       showAgenda: true),

              view: CalendarView.month,
              controller: calController,
              dataSource: MeetingDataSource(userUid: user.uid),
            ),
          ),
        ],
      ),
    );
  }
}
