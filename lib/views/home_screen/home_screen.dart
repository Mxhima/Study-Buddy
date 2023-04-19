import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/constants/text_strings.dart';
import 'package:study_buddy/views/profile_screen/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tAppTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: tCardBgColor),
            child: IconButton(
              onPressed: () => Get.to(() => ProfileScreen()),
              icon: const Image(
                image: AssetImage(tUserProfileImage),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
                child: Column(
              children: [
                Text(
                  DateTime.now().hour.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 75, color: tPrimaryColor),
                ),
                Text(
                  DateTime.now().minute.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 55, color: tPrimaryColor),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
