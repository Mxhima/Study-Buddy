import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/controllers/todo_controller.dart';
import 'package:study_buddy/models/task_model.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:study_buddy/views/pomodoroTimer_screen/pomodoro_timer_screen.dart';
import 'package:study_buddy/views/todo_screen/addTask_screen.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});
  final themeController = Get.find<ThemeController>();
  final DocumentReference DocRef =
      FirebaseFirestore.instance.collection('tasks').doc("docId");

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
      body: StreamBuilder<QuerySnapshot>(
        stream: getTasks(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Task> tasks =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            final Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Task.fromMap(data, document.id);
          }).toList();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              final task = tasks[index];

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.all(8.0),
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 1, //spread radius
                        blurRadius: 3, // blur radius
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: ListTile(
                  title: Row(
                    children: [
                      // GestureDetector(
                      //   onTap: () {},
                      // ),
                      SizedBox(
                          width: 15,
                          child: Checkbox(
                            value: task.completed,
                            onChanged: (value) {
                              //updateTask(docID, data);

                              // Future<void> updateTaskCompletionStatus(
                              //     String id, bool isCompleted) async {
                              //   await FirebaseFirestore.instance
                              //       .collection('tasks')
                              //       .doc(id)
                              //       .update({
                              //     'isCompleted': isCompleted,
                              //   });
                              // }
                            },
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          task.title,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                        icon: const Icon(LineAwesomeIcons.trash),
                        onPressed: () async {
                          DocRef.get().then((doc) {
                            if (doc.exists) {
                              final String docId = doc.id;
                              FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(docId)
                                  .delete();
                            } else {
                              Get.snackbar("Error", "Document not found");
                            }
                          });
                          // final DocumentSnapshot snapshot = await DocRef.get();
                          // if (snapshot.exists) {
                          //   final String docId = snapshot.id;
                          //   FirebaseFirestore.instance
                          //       .collection('tasks')
                          //       .doc(snapshot.id)
                          //       .delete();
                          // } else {
                          //   Get.snackbar("Error", "Document ID not found");
                          // }
                          //deleteTask(Task.fromMap(documentId));

                          // Deleting the tasks from Firestore.
                          // Future<void> deleteTask(String id) async {
                          //   await FirebaseFirestore.instance
                          //       .collection('tasks')
                          //       .doc(id)
                          //       .delete();
                          // }
                        },
                      ))
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(LineAwesomeIcons.play),
                    color: tPrimaryColor,
                    onPressed: () {
                      Get.to(() => const PomodoroTimer());
                    },
                  ),
                ),
              );
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
    );
  }
}
