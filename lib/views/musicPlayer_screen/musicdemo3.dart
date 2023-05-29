// import 'package:audio_manager/audio_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:study_buddy/constants/colors.dart';
// import '../../utils/theme/theme.dart';
// import '../../utils/theme/theme_controller.dart';
// import 'song_widget.dart';

// class MusicDemo3 extends StatefulWidget {
//   @override
//   State<MusicDemo3> createState() => _MusicDemo3State();
// }

// class _MusicDemo3State extends State<MusicDemo3> {
//   final themeController = Get.find<ThemeController>();
//   AudioManager audiomanager = AudioManager.instance;
//   bool showVol = false;
//   PlayMode playMode = AudioManager.instance.playMode;
//   bool isPlaying = false;
//   double? _slider;

//   @override
//   void initState() {
//     super.initState();
//     setupAudio();
//   }

//   void setupAudio() {
//     audiomanager.onEvents((events, args) {
//       switch (events) {
//         case AudioManagerEvents.start:
//           _slider = 0;
//           break;
//         case AudioManagerEvents.seekComplete:
//           _slider = audiomanager.position.inMilliseconds /
//               audiomanager.duration.inMilliseconds;
//           setState(() {});
//           break;
//         case AudioManagerEvents.playstatus:
//           isPlaying = audiomanager.isPlaying;
//           setState(() {});
//           break;
//         case AudioManagerEvents.timeupdate:
//           _slider = audiomanager.position.inMilliseconds /
//               audiomanager.duration.inMilliseconds;
//           audiomanager.updateLrc(args["position"].toString());
//           setState(() {});
//           break;
//         case AudioManagerEvents.ended:
//           audiomanager.next();
//           setState(() {});
//           break;
//         default:
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(LineAwesomeIcons.angle_left),
//           ),
//           title: Text(
//             "Lecturers",
//             style: Theme.of(context).textTheme.titleSmall,
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   if (Get.isDarkMode) {
//                     themeController.changeTheme(TAppTheme.lightTheme);
//                     themeController.saveTheme(false);
//                   } else {
//                     themeController.changeTheme(TAppTheme.darkTheme);
//                     themeController.saveTheme(true);
//                   }
//                 },
//                 icon:
//                     Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
//           ]),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             height: 500,
//             child: FutureBuilder(
//               future: FlutterAudioQuery()
//                   .getSongs(sortType: SongSortType.RECENT_YEAR),
//               builder: (context, snapshot) {
//                 List<SongInfo>? songInfo = snapshot.data;
//                 if (snapshot.hasData) {
//                   return SongWidget(songList: songInfo!);
//                 }
//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         CircularProgressIndicator(),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           "Loading .....",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           bottomPanel(),
//         ],
//       ),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     if (duration == null) return "--:--";
//     int minute = duration.inMinutes;
//     int second = (duration.inSeconds > 60)
//         ? (duration.inSeconds % 60)
//         : duration.inSeconds;
//     String format =
//         "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
//     return format;
//   }

//   Widget songProgress(BuildContext context) {
//     var style = TextStyle(color: Colors.black);
//     return Row(
//       children: <Widget>[
//         Text(
//           _formatDuration(audiomanager.position),
//           style: style,
//         ),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5),
//             child: SliderTheme(
//               data: SliderTheme.of(context).copyWith(
//                 trackHeight: 2,
//                 thumbColor: Colors.blueAccent,
//                 overlayColor: Colors.blue,
//                 thumbShape: RoundSliderThumbShape(
//                   disabledThumbRadius: 5,
//                   enabledThumbRadius: 5,
//                 ),
//                 overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
//                 activeTrackColor: tPrimaryColor,
//                 inactiveTrackColor: tWhiteColor,
//               ),
//               child: Slider(
//                 value: _slider ?? 0,
//                 onChanged: (value) {
//                   setState(() {
//                     _slider = value;
//                   });
//                 },
//                 onChangeEnd: (value) {
//                   if (audiomanager.duration != null) {
//                     Duration msec = Duration(
//                         milliseconds:
//                             (audiomanager.duration.inMilliseconds * value)
//                                 .round());
//                     audiomanager.seekTo(msec);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//         Text(
//           _formatDuration(audiomanager.duration),
//           style: style,
//         ),
//       ],
//     );
//   }

//   Widget bottomPanel() {
//     return Column(children: <Widget>[
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: songProgress(context),
//       ),
//       Container(
//         padding: EdgeInsets.symmetric(vertical: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             CircleAvatar(
//               child: Center(
//                 child: IconButton(
//                     icon: Icon(
//                       Icons.skip_previous,
//                       color: Colors.white,
//                     ),
//                     onPressed: () => audiomanager.previous()),
//               ),
//               backgroundColor: Colors.cyan.withOpacity(0.3),
//             ),
//             CircleAvatar(
//               radius: 30,
//               child: Center(
//                 child: IconButton(
//                   onPressed: () async {
//                     audiomanager.playOrPause();
//                   },
//                   padding: const EdgeInsets.all(0.0),
//                   icon: Icon(
//                     audiomanager.isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             CircleAvatar(
//               backgroundColor: Colors.cyan.withOpacity(0.3),
//               child: Center(
//                 child: IconButton(
//                     icon: Icon(
//                       Icons.skip_next,
//                       color: Colors.white,
//                     ),
//                     onPressed: () => audiomanager.next()),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
