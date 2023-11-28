import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
class UpcomingEventsComponent extends StatefulWidget {
  const UpcomingEventsComponent({super.key});

  @override
  _UpcomingEventsComponentState createState() =>
      _UpcomingEventsComponentState();
}
Future<String> createGoogleCalendarEventWithMeetLink(DateTime date, String specialistEmail, String specialistName) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      calendar.CalendarApi.calendarScope,
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  final GoogleSignInAccount? account = await googleSignIn.signIn();

  if (account != null) {
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    // Create an appointment on the user's Google Calendar
    calendar.Event event = calendar.Event()
        ..summary = 'Cita con $specialistName'
        ..start = calendar.EventDateTime()
        ..end = calendar.EventDateTime()
        ..start!.dateTime = date
        ..end!.dateTime = date.add(const Duration(hours: 1));

      // Add attendees to the event
      event.attendees = [
        calendar.EventAttendee(email: specialistEmail)
      ];

    // Add Google Meet link to the event
    calendar.ConferenceData conferenceData = calendar.ConferenceData();
    calendar.CreateConferenceRequest conferenceRequest =
        calendar.CreateConferenceRequest();
    var uuid = const Uuid();
    conferenceRequest.requestId = uuid.v4();
    conferenceData.createRequest = conferenceRequest;
    event.conferenceData = conferenceData;

    // Create a new http.Client instance
    final client = http.Client();

    // Create a new http.Request instance
   final request = http.Request(
      'POST',
      Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/primary/events?conferenceDataVersion=1&sendUpdates=all'),
    );

    // Set the access token in the request headers
    request.headers['Authorization'] = 'Bearer ${googleAuth.accessToken}';

    // Set the request body as JSON
    request.body = jsonEncode(event.toJson());

    // Send the request and get the response
    final response = await client.send(request);
    final responseBody = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseBody);
    final googleMeetLink = responseJson['hangoutLink'];

    // Close the http.Client instance
    client.close();

    return googleMeetLink;
  } else {
    throw Exception('Google Sign In failed');
  }
}
String capitalize(String text) {
  if (text.isEmpty) {
    return text;
  } else {
    return text[0].toUpperCase() + text.substring(1);
  }
}

class _UpcomingEventsComponentState extends State<UpcomingEventsComponent> {
  Stream<List<Map<String, dynamic>>> fetchCitas() {
    CollectionReference citas = FirebaseFirestore.instance.collection('citas');
    String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    return citas
        .where('requester', isEqualTo: currentUserEmail)
        .snapshots()
        .map((querySnapshot) {
      List<Map<String, dynamic>> citasList = [];

      for (var doc in querySnapshot.docs) {
        try {
          Timestamp timestamp = doc['date'];
          DateTime date = timestamp.toDate();

          // Check if the event date is in the future
          if (date.isAfter(DateTime.now())) {
            citasList.add({
              'id': doc.id, // Add the document ID here
              'requester': doc['requester'],
              'attendee': doc['attendee'],
              'attendeeName': doc['attendeeName'], // Add the attendee name here
              'date': date,
              'meet': doc['googleMeetLink'],
            });
          }
        } catch (e) {
          // Print document ID if there's an error
          // Print the error
        }
      }

      return citasList;
    });
  }

  openMeetLink(String url) async {
    if (Platform.isAndroid && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchCitas(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('An error has occurred'));
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                DateTime startDate = snapshot.data![index]['date'];
                DateTime endDate = startDate.add(const Duration(hours: 1));
                String formattedStartDate = capitalize(
                    DateFormat('EEE d, HH:mm', 'es').format(startDate));
                String formattedEndDate = capitalize(
                    DateFormat('EEE d, HH:mm', 'es').format(endDate));
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF8FB5E1), Color(0xFF8FB5E1)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Choose an option'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: const Text("Reschedule"),
                                    // Reschedule logic
                                    onTap: () {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  ).then((date) {
    if (date != null) {
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((time) {
        if (time != null) {
          DateTime chosenDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute);

          // Check if the chosen time is within working hours
          DateTime startOfWorkingHours =
              DateTime(date.year, date.month, date.day, 8);
          DateTime endOfWorkingHours =
              DateTime(date.year, date.month, date.day, 17);
          if (chosenDateTime.isBefore(startOfWorkingHours) ||
              chosenDateTime.isAfter(endOfWorkingHours)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'The chosen time is outside of working hours')));
            return;
          }

          // Fetch the events for the chosen date
          FirebaseFirestore.instance
              .collection('citas')
              .where('date',
                  isGreaterThanOrEqualTo:
                      DateTime(date.year, date.month, date.day))
              .where('date',
                  isLessThan: DateTime(date.year, date.month, date.day + 1))
              .get()
              .then((querySnapshot) async {
            for (var doc in querySnapshot.docs) {
              DateTime eventDateTime = doc['date'].toDate();

              // Check if there's an event at the chosen time
              if (eventDateTime.isAtSameMomentAs(chosenDateTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'The chosen time is occupied')));
                return;
              }
            }

            // If the chosen time is not occupied, update the Firestore document
            // Generate a new Google Meet link
            String newMeetLink = await createGoogleCalendarEventWithMeetLink(
              chosenDateTime,
              snapshot.data![index]['attendee'],
              snapshot.data![index]['attendeeName'],
            );
            // Add the new event to Firestore
            await FirebaseFirestore.instance.collection('citas').add({
              'date': chosenDateTime,
              'attendee': snapshot.data![index]['attendee'],
              'requester': snapshot.data![index]['requester'],
              'attendeeName': snapshot.data![index]['attendeeName'],
              'googleMeetLink': newMeetLink,
            });

            // Delete the old event
            await FirebaseFirestore.instance.collection('citas').doc(snapshot.data![index]['id']).delete();
          });
        }
      });
    }
  });
},
                                  ),
                                  const Padding(padding: EdgeInsets.all(8.0)),
                                  GestureDetector(
                                    child: const Text("Eliminar"),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Eliminar cita'),
                                            content: const Text(
                                                'Esta seguro que desea eliminar la cita?'),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors
                                                      .black, // Change text color
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors
                                                      .red, // Change background color
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('citas')
                                                      .doc(snapshot.data![index]
                                                          ['id'])
                                                      .delete();
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Eliminar'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: const Icon(Icons.event,
                          color: Colors.white, size: 40),
                      title: Text(
                        'Cita con: ${snapshot.data![index]['attendeeName']}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Desde: $formattedStartDate',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                          Text('Hasta: $formattedEndDate',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.video_call, color: Colors.white),
                        onPressed: () =>
                            openMeetLink(snapshot.data![index]['meet']),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No tienes citas pendientes'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
