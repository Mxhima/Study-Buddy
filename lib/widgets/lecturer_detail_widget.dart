import 'package:flutter/material.dart';

class RecordsModal extends StatelessWidget {
  final List<Map<String, dynamic>> records;

  RecordsModal({required this.records});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Records'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return ListTile(
              title: Text(record['fullname']),
              subtitle: Text(record['faculty']),
              trailing: Text(record["email"]),
              // Add more fields as needed
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
