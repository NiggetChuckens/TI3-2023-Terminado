// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class RecursosPage extends StatefulWidget {
  const RecursosPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RecursosPageState createState() => _RecursosPageState();
}

class _RecursosPageState extends State<RecursosPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  static const int appointmentDurationInHours =
      1; // Set the appointment duration

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
          title: const Text('Appointment Created Successfully'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Scheduled Date and Time:'),
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
                Navigator.of(context).pop();
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
        print('Access token: ${googleAuth.accessToken}');

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

        // Create a new http.Client instance
        final client = http.Client();

        // Create a new calendar.CalendarApi instance
        calendar.CalendarApi calendarApi = calendar.CalendarApi(client);

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
        if (response.statusCode == 200) {
          print('Appointment created successfully');
          print('Scheduled Time: ${selectedDateTime.toString()}');
          _showSuccessDialog(selectedDateTime); // Show success dialog
        } else {
          print(
              'Failed to create appointment. Status code: ${response.statusCode}');
        }
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
            print('Refreshed access token: ${refreshedAuth.accessToken}');

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

            // Create a new http.Client instance
            final client = http.Client();

            // Create a new calendar.CalendarApi instance
            calendar.CalendarApi calendarApi = calendar.CalendarApi(client);

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
            if (response.statusCode == 200) {
              print('Appointment created successfully');
              print('Scheduled Time: ${selectedDateTime.toString()}');
              _showSuccessDialog(selectedDateTime); // Show success dialog
            } else {
              print(
                  'Failed to create appointment. Status code: ${response.statusCode}');
            }
          }
        } catch (refreshError) {
          print('Failed to refresh access token: $refreshError');
        }
      } else {
        print('Failed to sign in with Google: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recursos'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.deepPurple],
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
                    _selectedTime =
                        null; // Reset selected time when a new date is selected
                  });
                  _selectTime(context);
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 22, 4, 56).withOpacity(0.5),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                  ),
                ),
              ),
              if (_selectedDay != null)
                Column(
                  children: [
                    ListTile(
                      title: Text(
                          'Selected Date: ${DateFormat.yMd().format(_selectedDay!)}'), // Display only the date
                      subtitle: Text(
                          'Selected Time: ${_selectedTime?.format(context) ?? 'Not selected'}'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '1-hour time frame',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              if (_selectedDay != null && _selectedTime != null)
                ElevatedButton(
                  onPressed: signInWithGoogle,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,
                  ),
                  child: const Text('Create Appointment'),
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
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }
}
