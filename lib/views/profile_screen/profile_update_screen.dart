import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';

import '../../constants/colors.dart';
import '../../utils/theme/theme.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final themeController = Get.find<ThemeController>();
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _facultyController = TextEditingController();
  final _degreeController = TextEditingController();
  final _interestController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneController.dispose();
    _facultyController.dispose();
    _degreeController.dispose();
    _interestController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the currently logged-in user's ID
    final userId = FirebaseAuth.instance.currentUser!.uid;
    // Retrieve the user's data from Firestore
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        // Populate the input fields with the retrieved data
        _fullnameController.text = userData['FullName'];
        _phoneController.text = userData['PhoneNo'];
        _facultyController.text = userData['Faculty'];
        _degreeController.text = userData['Degree'];
        _interestController.text = userData['AcademicInterests'];
      }
    });
  }

  Future<void> _updateUserProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final name = _fullnameController.text;
    final phone = _phoneController.text;
    final faculty = _facultyController.text;
    final degree = _degreeController.text;
    final interests = _interestController.text;

    try {
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);
      final userData = {
        'FullName': name,
        'PhoneNo': phone,
        'Faculty': faculty,
        'Degree': degree,
        'AcademicInterests': interests,
      };

      await userRef.update(userData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                themeController.changeTheme(TAppTheme.lightTheme);
                themeController.saveTheme(false);
              } else {
                themeController.changeTheme(TAppTheme.darkTheme);
                themeController.saveTheme(true);
              }
            },
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: _fullnameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: _facultyController,
                decoration: InputDecoration(labelText: 'Faculty'),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: _degreeController,
                decoration: InputDecoration(labelText: 'Degree'),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                style: const TextStyle(fontSize: 16),
                controller: _interestController,
                decoration: InputDecoration(labelText: 'Academic Interests'),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updateUserProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                  ),
                  child: const Text(
                    'Update Profile',
                    style: TextStyle(color: tDarkColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
