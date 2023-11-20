// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, duplicate_ignore, empty_catches

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  final String specialistEmail;

  const CalendarPage({Key? key, required this.specialistEmail})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  static const int appointmentDurationInHours =
      1; // Set the appointment duration
  Future<bool> addEventToFirestore(
<<<<<<< HEAD
<<<<<<< HEAD
      DateTime date, String attendeeEmail, String requesterEmail) async {
=======
    DateTime date,
    String attendeeEmail,
    String requesterEmail,
    String attendeeName,
    String googleMeetLink,
  ) async {
>>>>>>> Dev-Rob
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // Fetch all events for the day
    final QuerySnapshot result = await _firestore
        .collection('citas')
        .where('date',
            isGreaterThanOrEqualTo:
                DateTime(date.year, date.month, date.day, 0, 0))
        .where('date',
            isLessThan: DateTime(date.year, date.month, date.day + 1, 0, 0))
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    final DateTime newEventEndTime =
        date.add(const Duration(hours: appointmentDurationInHours));

    for (var doc in documents) {
      final DateTime existingEventStartTime = doc['date'].toDate();
      final DateTime existingEventEndTime = existingEventStartTime
          .add(const Duration(hours: appointmentDurationInHours));

      if ((date.isAfter(existingEventStartTime) &&
              date.isBefore(existingEventEndTime)) ||
          (newEventEndTime.isAfter(existingEventStartTime) &&
              newEventEndTime.isBefore(existingEventEndTime))) {
        _showDialog('Ya hay una cita!');
        return false;
      }
<<<<<<< HEAD
=======
  DateTime date, 
  String attendeeEmail, 
  String requesterEmail, 
  String attendeeName, 
  String googleMeetLink, 
)
 async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Fetch all events for the day
  final QuerySnapshot result = await _firestore
      .collection('citas')
      .where('date',
          isGreaterThanOrEqualTo:
              DateTime(date.year, date.month, date.day, 0, 0))
      .where('date',
          isLessThan: DateTime(date.year, date.month, date.day + 1, 0, 0))
      .get();

  final List<DocumentSnapshot> documents = result.docs;
  final DateTime newEventEndTime =
      date.add(const Duration(hours: appointmentDurationInHours));

  for (var doc in documents) {
    final DateTime existingEventStartTime = doc['date'].toDate();
    final DateTime existingEventEndTime = existingEventStartTime
        .add(const Duration(hours: appointmentDurationInHours));

    if ((date.isAfter(existingEventStartTime) &&
            date.isBefore(existingEventEndTime)) ||
        (newEventEndTime.isAfter(existingEventStartTime) &&
            newEventEndTime.isBefore(existingEventEndTime))) {
      _showDialog('Ya hay una cita!');
      return false;
>>>>>>> Dev-Nico
=======
>>>>>>> Dev-Rob
    }

    // No overlapping event exists, add the event
    await _firestore.collection('citas').add({
      'date': date,
      'attendee': attendeeEmail,
      'requester': requesterEmail,
    });

    return true;
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 3;
                });
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show a success dialog
  void _showSuccessDialog(DateTime scheduledDateTime) {
    final endTime = scheduledDateTime
        .add(const Duration(hours: appointmentDurationInHours));
    final formattedStartTime = DateFormat.jm().format(scheduledDateTime);
    final formattedEndTime = DateFormat.jm().format(endTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cita agendada exitosamente'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Fecha y hora seleccionada:'),
              Text(DateFormat.yMd()
                  .add_jm()
                  .format(scheduledDateTime)), // Display date and time
              const SizedBox(height: 10),
              const Text('Time Frame:'),
              Text(
                  '$formattedStartTime - $formattedEndTime'), // Display the time frame
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 3;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        calendar.CalendarApi.calendarScope,
        'https://www.googleapis.com/auth/calendar',
      ],
    );

    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        final GoogleSignInAuthentication googleAuth =
            await account.authentication;

        // Now you can use googleAuth.accessToken to make authenticated API requests

        // Check if a date and time are selected
        if (_selectedDay == null || _selectedTime == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a date and time'),
            ),
          );
          return;
        }

        final DateTime selectedDateTime = DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        // Create an appointment on the user's Google Calendar
        calendar.Event event = calendar.Event()
          ..summary = 'Appointment'
          ..start = calendar.EventDateTime()
          ..end = calendar.EventDateTime()
          ..start!.dateTime = selectedDateTime
          ..end!.dateTime = selectedDateTime.add(const Duration(hours: 1));
        event.attendees = [
          calendar.EventAttendee(email: widget.specialistEmail)
        ];
        // Create a new http.Client instance
        final client = http.Client();

        // Create a new calendar.CalendarApi instance

<<<<<<< HEAD
        // Create a new http.Request instance
        final request = http.Request(
          'POST',
          Uri.parse(
              'https://www.googleapis.com/calendar/v3/calendars/primary/events'),
        );

        // Set the access token in the request headers
        request.headers['Authorization'] = 'Bearer ${googleAuth.accessToken}';

        // Set the request body as JSON
        request.body = jsonEncode(event.toJson());

        // Send the request and get the response
        final response = await client.send(request);

        // Close the http.Client instance
        client.close();

        // Check the response status code
        // Check the response status code
        // Check the response status code
if (response.statusCode == 200) {
  print('Appointment created successfully with atendee: ${widget.specialistEmail}');          
  print('Scheduled Time: ${selectedDateTime.toString()}');
  // Add the event to Firestore
  bool eventAdded = await addEventToFirestore(selectedDateTime, widget.specialistEmail, account.email);
  if (eventAdded) {
    _showSuccessDialog(selectedDateTime); // Show success dialog only if event was added to Firestore
    print('Event added to Firestore with attendee: ${widget.specialistEmail}');
  }
} else {
  print(
      'Failed to create appointment. Status code: ${response.statusCode}');
}
=======
          // Create a new calendar.CalendarApi instance

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
          
        
        if (response.statusCode == 200) {
          // Add the event to Firestore
          bool eventAdded = await addEventToFirestore(
  selectedDateTime, 
  widget.specialistEmail, 
  account.email, 
  widget.specialistName, 
  googleMeetLink
);
          if (eventAdded) {
            _showSuccessDialog(
                selectedDateTime); // Show success dialog only if event was added to Firestore
          }
<<<<<<< HEAD
        } else {
        }
>>>>>>> Dev-Nico
=======
        } else {}
>>>>>>> Dev-Rob
      }
    } catch (error) {
      if (error.toString().contains('access_token_expired')) {
        // Access token expired, refresh the authentication token
        try {
          final GoogleSignInAccount? refreshedAccount =
              await googleSignIn.signInSilently();

          if (refreshedAccount != null) {
            final GoogleSignInAuthentication refreshedAuth =
                await refreshedAccount.authentication;

            // Now you can use refreshedAuth.accessToken to make authenticated API requests

            // Check if a date and time are selected
            if (_selectedDay == null || _selectedTime == null) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a date and time'),
                ),
              );
              return;
            }

            final DateTime selectedDateTime = DateTime(
              _selectedDay!.year,
              _selectedDay!.month,
              _selectedDay!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            );

            // Create an appointment on the user's Google Calendar
            calendar.Event event = calendar.Event()
              ..summary = 'Appointment'
              ..start = calendar.EventDateTime()
              ..end = calendar.EventDateTime()
              ..start!.dateTime = selectedDateTime
              ..end!.dateTime = selectedDateTime.add(const Duration(hours: 1));
            event.attendees = [
              calendar.EventAttendee(email: widget.specialistEmail)
            ];

            // Create a new http.Client instance
            final client = http.Client();

            // Create a new calendar.CalendarApi instance

            // Create a new http.Request instance
            final request = http.Request(
              'POST',
              Uri.parse(
                  'https://www.googleapis.com/calendar/v3/calendars/primary/events'),
            );

            // Set the access token in the request headers
            request.headers['Authorization'] =
                'Bearer ${refreshedAuth.accessToken}';

            // Set the request body as JSON
            request.body = jsonEncode(event.toJson());

            // Send the request and get the response
            final response = await client.send(request);

            // Close the http.Client instance
            client.close();

            // Check the response status code
            // Check the response status code
<<<<<<< HEAD
if (response.statusCode == 200) {
  print('Appointment created successfully with atendee: ${widget.specialistEmail}');
  print('Scheduled Time: ${selectedDateTime.toString()}');
  // Add the event to Firestore
  bool eventAdded = await addEventToFirestore(selectedDateTime, widget.specialistEmail, refreshedAccount.email);
  if (eventAdded) {
    _showSuccessDialog(selectedDateTime); // Show success dialog only if event was added to Firestore
  }
} else {
  print(
      'Failed to create appointment. Status code: ${response.statusCode}');
}
=======
            if (response.statusCode == 200) {
              // Add the event to Firestore
              bool eventAdded = await addEventToFirestore(
              selectedDateTime, 
              widget.specialistEmail, 
              refreshedAccount.email, 
              widget.specialistName, 
              googleMeetLink
            );          
              if (eventAdded) {
                _showSuccessDialog(
                    selectedDateTime); // Show success dialog only if event was added to Firestore
              }
<<<<<<< HEAD
            } else {
            }
>>>>>>> Dev-Nico
=======
            } else {}
>>>>>>> Dev-Rob
          }
        } catch (refreshError) {}
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 188, 193, 198), Color.fromARGB(255, 211, 207, 215)],
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              TableCalendar(
  firstDay: DateTime.now(),
  lastDay: DateTime(2023, 12, 31),
  focusedDay: _focusedDay,
  calendarFormat: _calendarFormat,
  onFormatChanged: (format) {
    setState(() {
      _calendarFormat = format;
    });
  },
  onDaySelected: (selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _selectedTime = null; // Reset selected time when a new date is selected
    });
    _selectTime(context);
  },
  selectedDayPredicate: (day) {
    return isSameDay(_selectedDay, day);
  },
  calendarStyle: const CalendarStyle(
    todayDecoration: BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    weekendTextStyle: TextStyle(
      color: Colors.red,
    ),
    holidayTextStyle: TextStyle(
      color: Colors.green,
    ),
  ),
  calendarBuilders: CalendarBuilders(
    defaultBuilder: (context, date, _) {
      if (date.compareTo(DateTime.now()) < 0) {
        return Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Text(
            date.day.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        return null;
      }
    },
    markerBuilder: (context, date, events) {
      if (events.isNotEmpty) {
        return Positioned(
          right: 1,
          bottom: 1,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            width: 6.0,
            height: 6.0,
          ),
        );
      }
      return null;
    },
  ),
),
              if (_selectedDay != null)
                Column(
                  children: [
                    ListTile(
                      title: Text(
                          'Dia Seleccionado: ${DateFormat.yMd().format(_selectedDay!)}'), // Display only the date
                      subtitle: Text(
                          'Hora Seleccionado: ${_selectedTime?.format(context) ?? 'Not selected'}'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sesion de 1 hora',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              if (_selectedDay != null && _selectedTime != null)
                ElevatedButton(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Agendar Cita'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Check if the selected time is allowed
      if (selectedTime.hour < 8 || selectedTime.hour > 17) {
        // If it's not allowed, show a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Horario no permitido'),
              content: const Text('El horario de atencion es desde 8AM a 5PM'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // If it's allowed, set the selected time
        setState(() {
          _selectedTime = selectedTime;
        });
      }
    }
  }
}
