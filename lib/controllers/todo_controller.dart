import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
late String _userID;

// Add a task to Firestore.
Future<void> addTask(String title) {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(_auth.currentUser?.uid)
      .collection("tasks")
      .add({
    'title': title,
    'completed': false,
    'createdAt': FieldValue.serverTimestamp(),
  });
}

Future<void> updateTask(String docID, data) async {
  await FirebaseFirestore.instance.collection('tasks').doc(docID).update(data);
}

Future<void> deleteTask(String docID) async {
  await FirebaseFirestore.instance.collection('tasks').doc(docID).delete();
}

// Retrieve tasks from Firestore.
Stream<QuerySnapshot> getTasks() {
  return FirebaseFirestore.instance
      .collection('Users')
      .doc(_auth.currentUser?.uid)
      .collection("tasks")
      .orderBy('createdAt', descending: true)
      .snapshots();
}
