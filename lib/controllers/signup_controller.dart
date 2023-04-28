import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (error) {
      print(error);
      return null;
    }
  }
}

class DatabaseService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(String email, String uid) async {
    await users.doc(uid).set({
      'email': email,
    });
  }
}
