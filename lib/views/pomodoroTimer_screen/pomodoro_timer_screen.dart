// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:study_buddy/constants/colors.dart';

// class PomodoroTimer extends StatefulWidget {
//   const PomodoroTimer({super.key});

//   @override
//   State<PomodoroTimer> createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: tPrimaryColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text("25:00",
//                   style: TextStyle(color: Colors.white, fontSize: 48)),
//             ],
//           ),
//           const SizedBox(
//             height: 300,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     //_stopTimer();
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black87,
//                       shape: const CircleBorder(
//                           side: BorderSide(color: tWhiteColor))),
//                   child: const Padding(
//                     padding: EdgeInsets.all(30.0),
//                     child: Text(
//                       "STOP",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                   )),
//               ElevatedButton(
//                   onPressed: () {
//                     //_startTimer();
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black87,
//                       shape: const CircleBorder(
//                           side: BorderSide(color: tWhiteColor))),
//                   child: const Padding(
//                     padding: EdgeInsets.all(30.0),
//                     child: Text(
//                       "START",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ))
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
