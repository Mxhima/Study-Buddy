import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();
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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String?> _uploadImageToFirebase() async {
    if (_image == null) return null;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final imageName = 'profile_picture.jpg';
    final ref = FirebaseStorage.instance
        .ref()
        .child('profilePictures')
        .child(userId)
        .child(imageName);
    final uploadTask = ref.putFile(_image!);
    final snapshot = await uploadTask.whenComplete(() => null);

    if (snapshot.state == TaskState.success) {
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } else {
      return null;
    }
  }

  Future<void> _updateUserProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final name = _fullnameController.text;
    final phone = _phoneController.text;
    final faculty = _facultyController;
    final degree = _degreeController;
    final interests = _interestController;

    try {
      final profilePictureUrl = await _uploadImageToFirebase();
      FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'FullName': name,
        'PhoneNo': phone,
        'Faculty': faculty,
        'Degree': degree,
        'AcademicInterests': interests,
        'profilePicture': profilePictureUrl,
      });
      Get.snackbar("success", "updated data successfully");
    } catch (e) {
      Get.snackbar("Error", "$e.message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _fullnameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _facultyController,
                  decoration: InputDecoration(labelText: 'Faculty'),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _degreeController,
                  decoration: InputDecoration(labelText: 'Degree'),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _interestController,
                  decoration: InputDecoration(labelText: 'Academic Interests'),
                ),
                const SizedBox(height: 16.0),
                _image != null
                    ? Image.file(
                        _image!,
                        height: 100,
                        width: 100,
                      )
                    : Container(),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Profile Picture'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserProfile();
                    }
                  },
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
