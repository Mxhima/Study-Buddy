// Step -1 [ Creating the User Model ]

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.phoneNo,
    required this.password,
  });

  //Firestore stores data in JSON format.
  //So toJson() converts the data automatically.
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "PhoneNo": phoneNo,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        fullName: data["FullName"],
        phoneNo: data["PhoneNo"],
        password: data["Password"]);
  }
}
