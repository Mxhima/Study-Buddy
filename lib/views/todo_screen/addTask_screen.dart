import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/controllers/todo_controller.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final themeController = Get.find<ThemeController>();
  final TextEditingController _controller = TextEditingController();

  void _saveTask() async {
    final String text = _controller.text.trim();

    if (text.isNotEmpty) {
      await addTask(text);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: Text(
            "Add Task",
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
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60.0,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter task title...',
                  labelText: 'Title',
                ),
                controller: _controller,
                autofocus: true,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(
                'Add Task',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
