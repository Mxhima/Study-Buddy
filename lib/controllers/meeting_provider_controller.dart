import 'package:flutter/material.dart';
import 'package:study_buddy/models/calendar_meeting_model.dart';

class MeetingProvider extends ChangeNotifier {
  List<Meeting> meetings = [
    Meeting('conference', DateTime.now(),
        DateTime.now().add(const Duration(hours: 2)), Colors.green, false),
    Meeting('conference', DateTime.now(),
        DateTime.now().add(const Duration(hours: 2)), Colors.blue, false),
  ];

  void addMeeting() {
    meetings.add(
      Meeting('conference', DateTime.now(),
          DateTime.now().add(const Duration(hours: 2)), Colors.blue, false),
    );
    notifyListeners();
  }

  void editMeeting(int index) {
    meetings[index].eventName = 'Con $index $index';
  }
}
