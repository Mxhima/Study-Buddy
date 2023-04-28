import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/calendar_meeting_model.dart';

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }

//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }

class MeetingDataSource extends CalendarDataSource {
  final String userUid;
  MeetingDataSource({required this.userUid});

  @override
  Future<void> handleAppointments(List<Appointment> appointments,
      {bool isDateRangeSelection = false}) async {
    handleAppointments(appointments,
        isDateRangeSelection: isDateRangeSelection);

    for (var appointment in appointments) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('appointments')
          .doc(appointment.id.toString())
          .set({
        'title': appointment.subject,
        'description': appointment.notes,
        'startTime': appointment.startTime,
        'endTime': appointment.endTime,
      });
    }
  }

  @override
  Future<void> deleteAppointment(Appointment appointment) async {
    // super.deleteAppointment(appointment);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('appointments')
        .doc(appointment.id.toString())
        .delete();
  }

  @override
  Future<void> updateAppointment(
      Appointment oldAppointment, Appointment newAppointment) async {
    updateAppointment(oldAppointment, newAppointment);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('appointments')
        .doc(oldAppointment.id.toString())
        .update({
      'title': newAppointment.subject,
      'description': newAppointment.notes,
      'startTime': newAppointment.startTime,
      'endTime': newAppointment.endTime,
    });
  }

  @override
  Future<List<dynamic>> getCalendarEvents(
      DateTime startDate, DateTime endDate) async {
    var events = <Appointment>[];

    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .collection('appointments')
        .where('startTime', isGreaterThanOrEqualTo: startDate)
        .where('endTime', isLessThanOrEqualTo: endDate)
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data();

      events.add(Appointment(
        id: doc.id.hashCode,
        subject: data['title'],
        notes: data['description'],
        startTime: DateTime.parse(data['startTime'].toDate().toString()),
        endTime: DateTime.parse(data['endTime'].toDate().toString()),
      ));
    }

    return events;
  }
}
