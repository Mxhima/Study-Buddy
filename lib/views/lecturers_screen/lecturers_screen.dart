import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/utils/theme/theme.dart';
import 'package:study_buddy/utils/theme/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LecturerScreen extends StatefulWidget {
  const LecturerScreen({super.key});

  @override
  State<LecturerScreen> createState() => _LecturerScreenState();
}

class _LecturerScreenState extends State<LecturerScreen> {
  final themeController = Get.find<ThemeController>();
  final TextEditingController _controller = TextEditingController();

  bool _isModalShown = false;
  final Stream<QuerySnapshot> _lecturersStream =
      FirebaseFirestore.instance.collection('lecturers').snapshots();

  _launchPhone(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return StreamBuilder<QuerySnapshot>(
        stream: _lecturersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(LineAwesomeIcons.angle_left),
                ),
                title: Text(
                  "Lecturers",
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
                      icon: Icon(isDark
                          ? LineAwesomeIcons.sun
                          : LineAwesomeIcons.moon))
                ]),
            body: Material(
              color: tWhiteColor,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String title = data["fullname"];
                  String subtitle = data["faculty"];
                  String trailing = data["email"];

                  return lecturerCard(data);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 3, // blur radius
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child:
                                      Image(image: AssetImage(tLecturerImage))),
                              title: Text(
                                data["fullname"],
                                style: const TextStyle(fontSize: 22),
                              ),
                              subtitle: Text(
                                data["faculty"],
                                style: const TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Container(
                                //   decoration: BoxDecoration(
                                //       color: Colors.green,
                                //       borderRadius: BorderRadius.circular(15),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Colors.grey.withOpacity(0.5), //color of shadow
                                //           spreadRadius: 1, //spread radius
                                //           blurRadius: 3, // blur radius
                                //           offset: const Offset(0, 3),
                                //         ),
                                //       ]),
                                //   child: IconButton(
                                //     onPressed: () {},
                                //     icon: const Icon(LineAwesomeIcons.phone),
                                //   ),
                                // ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(LineAwesomeIcons.mail_bulk),
                                // ),
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        //backgroundColor: tPrimaryColor,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(45.0),
                                          topRight: Radius.circular(45.0),
                                        )),
                                        context: context,
                                        builder: (context) => Container(
                                            decoration: const BoxDecoration(
                                                //color: tPrimaryColor,
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                            )),
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                10.0),
                                                          )),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        "Lecturer Details",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      ListTile(
                                                        //leading: Icon(),
                                                        title: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5), //color of shadow
                                                                  spreadRadius:
                                                                      1, //spread radius
                                                                  blurRadius:
                                                                      3, // blur radius
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                ),
                                                              ]),
                                                          child: Column(
                                                            children: [
                                                              Text(data[
                                                                  "fullname"]),
                                                              Text(
                                                                data["faculty"],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            data["fullname"]),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )));
                                  },
                                  child: const Text("View"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }

  Widget lecturerCard(data) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
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
          children: [
            ListTile(
              leading: const SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: AssetImage(tLecturerImage))),
              title: Text(
                data["fullname"],
                style: const TextStyle(fontSize: 22),
              ),
              subtitle: Text(
                data["faculty"],
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(15),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5), //color of shadow
                //           spreadRadius: 1, //spread radius
                //           blurRadius: 3, // blur radius
                //           offset: const Offset(0, 3),
                //         ),
                //       ]),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(LineAwesomeIcons.phone),
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(LineAwesomeIcons.mail_bulk),
                // ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      //backgroundColor: tPrimaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      )),
                      context: context,
                      builder: (context) => Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        )),
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: Column(
                                children: <Widget>[
                                  const ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: tWhiteColor,
                                      child: Image(
                                          image: AssetImage(tLecturerImage)),
                                    ),
                                  ),
                                  ListTile(
                                    title: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(data["fullname"]),
                                          Text(data["faculty"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                            data["email"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(data["phone"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          Text(data["studyareas"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          Text(data["modules"],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(
                                            height: 160,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _launchPhone(data["phone"]);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: tWhiteColor,
                                              child: Image(
                                                  image: AssetImage(
                                                      tLecturerImage)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 100,
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              backgroundColor: tWhiteColor,
                                              child: Image(
                                                  image: AssetImage(
                                                      tLecturerImage)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text("View"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
