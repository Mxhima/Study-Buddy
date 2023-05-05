import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Timer'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Start Timer'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimerPage()),
            );
          },
        ),
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool _isRunning = false;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    timer?.cancel();
  }

  void _saveToFirestore() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final currentUserUid = _auth.currentUser?.uid;
    final mainCollectionRef = _firestore.collection('Users');
    final subCollectionRef =
        mainCollectionRef.doc(currentUserUid).collection('studySessions');
    int _totalPoints = 0;

    User? user = FirebaseAuth.instance.currentUser;
    int points = (_elapsedTime.inMinutes / 5).floor();
    int duration = _elapsedTime.inMinutes;

    final querySnapshot = await subCollectionRef.get();
    for (final documentSnapshot in querySnapshot.docs) {
      final data = documentSnapshot.data();

      final fieldValue = data['points'];
      _totalPoints += fieldValue as int;
    }
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(user!.uid)
    //     .collection('studySessions')
    //     .add({
    //   'points': points,
    //   'duration': duration,
    subCollectionRef.add({
      'User': currentUserUid,
      'Name': FirebaseAuth.instance.currentUser!.displayName,
      'points': points,
      'duration': duration,
    });
    FirebaseFirestore.instance.collection("Users").doc(currentUserUid).update({
      'points': _totalPoints,
    });
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_elapsedTime.inMinutes}:${(_elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                ),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: _saveToFirestore,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
