import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/models/study_session_model.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  bool _isRunning = false;
  Timer? _timer;
  int _duration = 25;
  int _minutes = 25;
  int _seconds = 0;
  int _points = 0;
  DateTime? _startTime;
  List<UserStudySession> _studySessions = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _isRunning = true;
      _startTime = DateTime.now();
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_minutes == 0 && _seconds == 0) {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
          _startTime = null;
          //_points += 1;
        });
        _showDialog();
        _recordStudySession();
      } else if (_seconds == 0) {
        setState(() {
          _minutes--;
          _seconds = 59;
        });
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _minutes = _duration;
      _seconds = 0;
      //_points = 0;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pomodoro Timer'),
          content: const Text('Time is up!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _recordStudySession() async {
    try {
      if (_startTime != null) {
        int duration = _duration - _minutes;
        duration += (_seconds > 0) ? 1 : 0;
        int points = (duration / 5).ceil();
        _points += points;
        UserStudySession session =
            UserStudySession(_startTime!, DateTime.now(), duration, points);
        _studySessions.add(session);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('studySessions')
            .add(session.toMap());
        Get.snackbar("Success", "Successfully updated points");
      }
    } catch (e) {
      Get.snackbar("Error", "$e.message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_minutes:${_seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // IconButton(
                //   onPressed: _isRunning
                //       ? null
                //       : () => setState(() {
                //             _duration = 25;
                //             _minutes = 25;
                //             _seconds = 0;
                //           }),
                //   icon: Icon(Icons.timer),
                // ),
                // TextButton(
                //   onPressed: _isRunning ? pauseTimer : startTimer,
                //   child: _isRunning ? Text('Pause') : Text('Start'),
                // ),
                // IconButton(
                //   onPressed: _isRunning ? null : resetTimer,
                //   icon: Icon(Icons.refresh),
                // ),

                ElevatedButton(
                  onPressed: _isRunning ? pauseTimer : startTimer,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Duration: $_duration minutes',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Slider(
              min: 1,
              max: 60,
              divisions: 59,
              value: _duration.toDouble(),
              onChanged: (double value) {
                setState(
                  () {
                    _duration = value.toInt();
                    _minutes = value.toInt();
                    _seconds = 0;
                  },
                );
              },
            ),
            Text(
              'Points: $_points',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
