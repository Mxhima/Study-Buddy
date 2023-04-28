import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/controllers/profile_controller.dart';
import 'package:study_buddy/models/user_model.dart';
import 'package:study_buddy/views/profile_screen/profile_screen.dart';
import '../../constants/text_strings.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            //future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  // Controllers
                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final fullName =
                      TextEditingController(text: userData.fullName);
                  final phoneNo = TextEditingController(text: userData.phoneNo);

                  return Column(children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                const Image(image: AssetImage(tProfileImage)),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: tPrimaryColor),
                              child: const Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.black,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: fullName,
                            initialValue: userData.fullName,
                            decoration: const InputDecoration(
                              label: Text(tFullName),
                              prefixIcon: Icon(Icons.person_outline_rounded),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            style: const TextStyle(fontSize: 16),
                            controller: email,
                            initialValue: userData.email,
                            decoration: const InputDecoration(
                              label: Text(tEmail),
                              prefixIcon: Icon(Icons.email_outlined),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            style: const TextStyle(fontSize: 16),
                            controller: phoneNo,
                            initialValue: userData.phoneNo,
                            decoration: const InputDecoration(
                              label: Text(tPhoneNo),
                              prefixIcon: Icon(Icons.phone_android_outlined),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            style: const TextStyle(fontSize: 16),
                            controller: password,
                            initialValue: userData.password,
                            decoration: const InputDecoration(
                              label: Text(tPassword),
                              prefixIcon: Icon(Icons.fingerprint_outlined),
                            )),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                final userData = UserModel(
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                  fullName: fullName.text.trim(),
                                  phoneNo: phoneNo.text.trim(),
                                );

                                //await controller.updateUserRecords(userData);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tPrimaryColor,
                                side: BorderSide.none,
                              ),
                              child: const Text(
                                tEditProfile,
                                style: TextStyle(color: tDarkColor),
                              )),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text.rich(
                              TextSpan(
                                text: tJoined,
                                style: TextStyle(fontSize: 12),
                                children: [
                                  TextSpan(
                                      text: tJoinedAt,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ))
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.1),
                                  elevation: 0,
                                  foregroundColor: Colors.red,
                                  side: BorderSide.none),
                              child: const Text(tDelete),
                            )
                          ],
                        ),
                      ],
                    ))
                  ]);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Text("Something went wrong");
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
