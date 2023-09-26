// ignore_for_file: avoid_print
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecursosPage extends StatelessWidget {
  const RecursosPage({Key? key}) : super(key: key);

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

        // Create an appointment on the user's Google Calendar
        calendar.Event event = calendar.Event()
          ..summary = 'Appointment'
          ..start = calendar.EventDateTime()
          ..end = calendar.EventDateTime()
          ..start!.dateTime = DateTime.now().add(Duration(hours: 1))
          ..end!.dateTime = DateTime.now().add(Duration(hours: 2));

        // Create a new http.Client instance
        final client = http.Client();

        // Create a new calendar.CalendarApi instance
        calendar.CalendarApi calendarApi = calendar.CalendarApi(client);

        // Make authenticated API request
        await calendarApi.events.insert(event, 'primary');

        // Close the http.Client instance
        client.close();
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

            // Create an appointment on the user's Google Calendar
            calendar.Event event = calendar.Event()
              ..summary = 'Appointment'
              ..start = calendar.EventDateTime()
              ..end = calendar.EventDateTime()
              ..start!.dateTime = DateTime.now().add(Duration(hours: 1))
              ..end!.dateTime = DateTime.now().add(Duration(hours: 2));

            // Create a new http.Client instance
            final client = http.Client();

            // Create a new calendar.CalendarApi instance
            calendar.CalendarApi calendarApi = calendar.CalendarApi(client);

            // Make authenticated API request
            await calendarApi.events.insert(event, 'primary');

            // Close the http.Client instance
            client.close();
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
      body: Center(
        child: ElevatedButton(
          onPressed: signInWithGoogle,
          child: const Text('Sign in with Google and Create Appointment'),
        ),
      ),
    );
  }
}
