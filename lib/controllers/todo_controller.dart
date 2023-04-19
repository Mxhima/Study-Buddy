import 'package:cloud_firestore/cloud_firestore.dart';

// Add a task to Firestore.
Future<void> addTask(String title) {
  return FirebaseFirestore.instance.collection('tasks').add({
    'title': title,
    'completed': false,
    'createdAt': FieldValue.serverTimestamp(),
  });
}

// Retrieve tasks from Firestore.
Stream<QuerySnapshot> getTasks() {
  return FirebaseFirestore.instance
      .collection('tasks')
      .orderBy('createdAt', descending: true)
      .snapshots();
}