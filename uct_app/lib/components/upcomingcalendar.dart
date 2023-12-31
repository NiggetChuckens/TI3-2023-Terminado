// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingEventsComponent extends StatefulWidget {
  const UpcomingEventsComponent({super.key});

  @override
  _UpcomingEventsComponentState createState() =>
      _UpcomingEventsComponentState();
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
                  child: ListTile(
                    leading:
                        const Icon(Icons.event, color: Colors.white, size: 40),
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
