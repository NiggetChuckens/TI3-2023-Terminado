import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.username,
    required this.picture,
    required this.description,
    required this.email,
  }) : super(key: key);

  final String username;
  final String picture;
  final String description;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.yellow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Perfil de $username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color:
                  Colors.amberAccent[700], // change this color to your liking
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // to make the column as small as possible
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(picture),
                ),
                const SizedBox(height: 16),
                Text(
                  username,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Email: $email',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Schedule Meeting'),
                  onPressed: () async {
                    final Uri calendarEventUri = Uri.https(
                        'calendar.google.com', '/calendar/r/eventedit', {
                      'text': 'Meeting with $username',
                      'dates':
                          '20220915T160000Z/20220915T170000Z', // replace with your dates in the format 'yyyyMMddTHHmmssZ/yyyyMMddTHHmmssZ'
                      'details': 'Meeting details go here',
                      'location': 'Meeting location',
                    });

                    try {
                      await launch(calendarEventUri.toString());
                    } catch (e) {
                      // ignore: avoid_print
                      print('Could not launch $calendarEventUri: $e');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
