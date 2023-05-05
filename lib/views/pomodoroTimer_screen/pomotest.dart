import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late Timer _timer;
  int _secondsRemaining = 0;
  int _pointsEarned = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _stopTimer();
        _earnPoints();
        _savePoints();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      _secondsRemaining = 25 * 60;
      _pointsEarned = 0;
      _isRunning = false;
    });
    _timer?.cancel();
    _savePoints();
  }

  void _earnPoints() {
    setState(
      () {
        _pointsEarned += (_secondsRemaining ~/ 60);
      },
    );
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
              '$_pointsEarned points',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 16),
            Text(
              '${_formatDuration(Duration(seconds: _secondsRemaining))}',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                  onPressed: _toggleTimer,
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: _resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _savePoints() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = _db.collection('Users').doc(user.uid);
      final data = {'points': _pointsEarned};
      await doc.set(data, SetOptions(merge: true));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
