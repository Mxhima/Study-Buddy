import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:study_buddy/constants/colors.dart';
import 'package:study_buddy/constants/image_strings.dart';
import 'package:study_buddy/views/lecturers_screen/lecturer_details_bottom_modal_screem.dart';

class LecturerScreen extends StatefulWidget {
  const LecturerScreen({super.key});

  @override
  State<LecturerScreen> createState() => _LecturerScreenState();
}

class _LecturerScreenState extends State<LecturerScreen> {
  bool _isModalShown = false;
  final Stream<QuerySnapshot> _lecturersStream =
      FirebaseFirestore.instance.collection('lecturers').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _lecturersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          // List<DocumentSnapshot> docs = snapshot.data!.docs;

          // List<CustomObject> objects = docs.map((doc) => CustomObject.fromSnapshot(doc)).toList();

          // return ListView.builder(
          //     itemCount: objects.length, itemBuilder: (context, Index) {});

          return Material(
            color: tPrimaryColor,
            child: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String title = data["fullname"];
                String subtitle = data["faculty"];
                String trailing = data["email"];

                //return lecturerCard(data);

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
                                      backgroundColor: tPrimaryColor,
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
                                            bottomRight: Radius.circular(10.0),
                                          )),
                                          padding: const EdgeInsets.all(30.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
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
                                                            color: Colors
                                                                .grey.shade200,
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
                                                                          FontWeight
                                                                              .normal),
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
                // return Container(
                //   margin: const EdgeInsets.all(5.0),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15.0),
                //       color: tWhiteColor,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.5), //color of shadow
                //           spreadRadius: 1, //spread radius
                //           blurRadius: 3, // blur radius
                //           offset: const Offset(0, 3),
                //         ),
                //       ]),
                //   child: ListTile(
                //     title: Text(
                //       title,
                //       style: const TextStyle(
                //           fontSize: 16.0, fontWeight: FontWeight.normal),
                //     ),
                //     subtitle: Text(subtitle),
                //     trailing: Text(trailing),
                //   ),
                // );
              }).toList(),
            ),
          );
        });
  }
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
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 3, // blur radius
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          ListTile(
              leading: Column(
                children: [
                  Text(data["fullname"]),
                  Text(data["email"]),
                ],
              ),
              // title: Text(
              //   data["fullname"],
              //   style: const TextStyle(
              //       fontSize: 16.0, fontWeight: FontWeight.normal),
              // ),
              subtitle: Column(
                children: [
                  Text(data["faculty"]),
                  Text(data["faculty"]),
                ],
              )
              //trailing: Text(data["faculty"]),
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
                onPressed: () {},
                child: const Text("View"),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
