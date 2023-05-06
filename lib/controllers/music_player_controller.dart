// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:just_audio/just_audio.dart';

// final AudioPlayer audioPlayer = AudioPlayer();

// Future<void> loadAudio(String audioUrl) async {
//   await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
// }

// void play() async {
//   await audioPlayer.play();
// }

// void pause() async {
//   await audioPlayer.pause();
// }

// void skipForward(Duration duration) async {
//   final newPosition = audioPlayer.position + duration;
//   await audioPlayer.seek(newPosition);
// }

// void skipBackward(Duration duration) async {
//   final newPosition = audioPlayer.position - duration;
//   await audioPlayer.seek(newPosition);
// }

// Future<void> showNotification(String title, String artist) async {
//   const android = AndroidNotificationDetails('channel id', 'channel name',
//       importance: Importance.high, priority: Priority.high, ticker: 'ticker');

//   const notificationDetails = NotificationDetails(android: android);

//   await FlutterLocalNotificationsPlugin()
//       .show(0, title, artist, notificationDetails, payload: 'item x');
// }

// void setVolume(double volume) {
//   audioPlayer.setVolume(volume);
// }

