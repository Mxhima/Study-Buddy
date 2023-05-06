import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class pomoTest3Timer extends StatefulWidget {
  const pomoTest3Timer({super.key});

  @override
  State<pomoTest3Timer> createState() => _pomoTest3TimerState();
}

class _pomoTest3TimerState extends State<pomoTest3Timer> {
  int _secondsLeft = 1500;
  int _pomodorosCompleted = 0;
  int _points = 0;
  int _shortBreaksTaken = 0;
  int _longBreaksTaken = 0;
  bool _isRunning = false;
  Timer? _timer;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String _userID;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void _resetData() {
    int _pomodorosCompleted = 0;
    int _points = 0;
    int _shortBreaksTaken = 0;
    int _longBreaksTaken = 0;
    _isRunning = false;
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    _userID = user!.uid;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _isRunning = false;
          _timer!.cancel();
          _addPoints();
          _pomodorosCompleted++;
          if (_pomodorosCompleted % 4 == 0) {
            _takeLongBreak();
          } else {
            _takeShortBreak();
          }
        }
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _secondsLeft = 1500;
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void _takeShortBreak() {
    setState(() {
      _secondsLeft = 300;
      _isRunning = false;
      _timer!.cancel();
      _shortBreaksTaken++;
    });
  }

  void _takeLongBreak() {
    setState(() {
      _secondsLeft = 900;
      _isRunning = false;
      _timer!.cancel();
      _longBreaksTaken++;
    });
  }

  void _addPoints() {
    int minutes = (1500 - _secondsLeft) ~/ 60;
    _points += minutes;
    final data = {
      'id': _userID,
      'name': _auth.currentUser!.displayName,
      'points': _points,
      'pomodorosCompleted': _pomodorosCompleted,
      'shortBreaksTaken': _shortBreaksTaken,
      'longBreaksTaken': _longBreaksTaken,
    };
    _firestore
        .collection("Users")
        .doc(_userID)
        .collection("studySessions")
        .add(data);
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes: ${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isRunning ? _formatTime(_secondsLeft) : 'Ready to start?',
              style: TextStyle(fontSize: 60.0),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: _resetTimer,
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Text(
              'Points: $_points\n'
              'Pomodoros completed: $_pomodorosCompleted\n'
              'Short breaks taken: $_shortBreaksTaken\n'
              'Long breaks taken: $_longBreaksTaken',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () {
                  _resetData();
                },
                child: Text("Reset data")),
          ],
        ),
      ),
    );
  }
}
