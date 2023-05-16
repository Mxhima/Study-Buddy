import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordHealth extends StatefulWidget {
  final String userID;
  final String name;

  const RecordHealth({Key? key, required this.userID, required this.name})
      : super(key: key);

  @override
  State<RecordHealth> createState() => _RecordHealthState();
}

class _RecordHealthState extends State<RecordHealth> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _heartbeatController = TextEditingController();
  bool backache = false;
  bool breathlessness = false;
  bool headache = false;
  bool itchyskin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffDECBEC),
        toolbarHeight: 60,
        centerTitle: true,
        title: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/logo.png'),
            ),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 360,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDECBEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Weight : ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: _weightController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            fillColor: Colors.lightBlue,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Height : ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: _heightController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            fillColor: Colors.lightBlue,
                            filled: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sugar Level : ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: _sugarController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            fillColor: Colors.lightBlue,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Blood Pressure : ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: _bloodController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            fillColor: Colors.lightBlue,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Heartbeat of the baby : ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: TextField(
                          controller: _heartbeatController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                            fillColor: Colors.lightBlue,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  title: const Text(
                    'Backache :',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: backache,
                  onChanged: (value) {
                    setState(() {
                      backache = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text(
                    'Breathlessness :',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: breathlessness,
                  onChanged: (value) {
                    setState(() {
                      breathlessness = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text(
                    'Headaches',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: headache,
                  onChanged: (value) {
                    setState(() {
                      headache = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text(
                    'Itchy Skin :',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: itchyskin,
                  onChanged: (value) {
                    setState(() {
                      itchyskin = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 360,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save health record to Firestore
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userID)
                          .collection('health_records')
                          .add({
                        'weight': _weightController.text,
                        'height': _heightController.text,
                        'sugar_level': _sugarController.text,
                        'blood_pressure': _bloodController.text,
                        'heartbeat': _heartbeatController.text,
                        'backache': backache,
                        'breathlessness': breathlessness,
                        'headache': headache,
                        'itchy_skin': itchyskin,
                      }).then((value) {
                        // Show success message and navigate back
                        Get.snackbar(
                          'Success',
                          'Health record saved successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Navigator.pop(context);
                      }).catchError((error) {
                        // Show error message
                        Get.snackbar(
                          'Error',
                          'Failed to save health record',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffDECBEC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
