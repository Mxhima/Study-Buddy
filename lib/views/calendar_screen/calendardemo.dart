// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class CalendarApp2 extends StatefulWidget {
//   const CalendarApp2({super.key});

//   @override
//   State<CalendarApp2> createState() => _CalendarApp2State();
// }

// class _CalendarApp2State extends State<CalendarApp2> {
//   List<Appointment> _events;
//   CalendarDataSource _dataSource;

//   @override
//   void initState() {
//     super.initState();
//     _events = <Appointment>[
//       Appointment(
//         startTime: DateTime.now(),
//         endTime: DateTime.now().add(Duration(hours: 1)),
//         subject: 'Event 1',
//         color: Colors.blue,
//       ),
//       Appointment(
//         startTime: DateTime.now().add(Duration(days: 1)),
//         endTime: DateTime.now().add(Duration(days: 1, hours: 2)),
//         subject: 'Event 2',
//         color: Colors.green,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }