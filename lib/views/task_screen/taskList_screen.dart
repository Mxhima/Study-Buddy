import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/home_screen/home_screen.dart';
import 'package:study_buddy/views/lecturers_screen/lecturers_screen.dart';
import 'package:study_buddy/views/musicPlayer_screen/musicdemo3.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomotest3.dart';
import 'package:study_buddy/views/task_screen/addTask_screen.dart';
import 'package:study_buddy/widgets/bottom_navbar_widget.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Task List',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("tasks")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data!.docs.map((doc) {
            return Task.fromSnapshot(doc);
          }).toList();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(task: tasks[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tPrimaryColor,
        onPressed: () async {
          Get.to(() => const AddTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(items: [
        CustomNavItem(title: "Home", icon: Icons.home, screen: HomeScreen()),
        CustomNavItem(
            title: "Lecturers", icon: Icons.school, screen: LecturerScreen()),
        // CustomNavItem(
        //     title: "Music", icon: Icons.music_note, screen: MusicDemo3()),
      ]),
    );
  }
}

class TaskTile extends StatefulWidget {
  final Task task;

  TaskTile({required this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool completed = false;

  @override
  void initState() {
    super.initState();
    completed = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxListTile(
            title: Text(
              widget.task.title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 16),
            ),
            value: completed,
            onChanged: (newValue) {
              setState(() {
                completed = newValue!;
              });
              updateTaskCompletion(widget.task.id, newValue!);
            },
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Get.to(() => pomoTest3Timer());
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  size: 20,
                ),
                label: const Text("Start"),
              ),
              const SizedBox(
                width: 190,
              ),
              TextButton.icon(
                onPressed: () {
                  deleteTask(widget.task.id);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ),
                label: const Text("Delete"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class Task {
  final String id;
  final String title;
  bool completed;

  Task({required this.id, required this.title, this.completed = false});

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: snapshot.id,
      title: data['title'],
      completed: data['completed'],
    );
  }
}

void updateTaskCompletion(String taskId, bool completed) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('tasks')
      .doc(taskId)
      .update({'completed': completed});
}

void deleteTask(String taskId) {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('tasks')
      .doc(taskId)
      .delete();
}
