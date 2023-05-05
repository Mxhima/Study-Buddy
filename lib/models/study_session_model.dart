import 'package:cloud_firestore/cloud_firestore.dart';

class UserStudySession {
  final DateTime startTime;
  final DateTime endTime;
  final int duration;
  final int points;

  UserStudySession(this.startTime, this.endTime, this.duration, this.points);

  Map<String, dynamic> toMap() {
    return {
      'start_time': Timestamp.fromDate(startTime),
      'end_time': Timestamp.fromDate(endTime),
      'duration': duration,
      'points': points,
    };
  }
}
