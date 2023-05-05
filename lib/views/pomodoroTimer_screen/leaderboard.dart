import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late Stream<QuerySnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<DocumentSnapshot> users = snapshot.data!.docs;
          users.sort((a, b) => b['points'] - a['points']);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index]['name']),
                subtitle: Text(
                    '${(users[index]['duration'] / 60).toStringAsFixed(0)} minutes - ${users[index]['points']} points'),
              );
            },
          );
        },
      ),
    );
  }
}
