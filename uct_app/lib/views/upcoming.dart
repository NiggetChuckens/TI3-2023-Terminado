// ignore_for_file: avoid_print, duplicate_ignore, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  _UpcomingEventsPageState createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  late Future<List<Map<String, dynamic>>> futureCitas;
  bool isAdmin = false;

  void checkAdminStatus() async {
    String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    final adminDoc = await FirebaseFirestore.instance
        .collection('administradores')
        .doc(currentUserEmail)
        .get();
    setState(() {
      isAdmin = adminDoc.exists;
      futureCitas = fetchCitas(); // Fetch citas after isAdmin is updated
    });
  }

  @override
  void initState() {
    super.initState();
    checkAdminStatus();
  }

  Future<List<Map<String, dynamic>>> fetchCitas() async {
    CollectionReference citas = FirebaseFirestore.instance.collection('citas');
    String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    List<Map<String, dynamic>> citasList = [];

    QuerySnapshot querySnapshot;
    if (isAdmin) {
      // If the user is an admin, fetch all events
      querySnapshot = await citas.get();
    } else {
      // If the user is not an admin, only fetch their own events
      querySnapshot =
          await citas.where('requester', isEqualTo: currentUserEmail).get();
    }

    for (var doc in querySnapshot.docs) {
      // ignore: avoid_print
      print('Document data: ${doc.data()}'); // Print document data

      try {
        Timestamp timestamp = doc['date'];
        DateTime date = timestamp.toDate();

        // Check if the event date is in the future
        if (date.isAfter(DateTime.now())) {
          citasList.add({
            'requester': doc['requester'],
            'attendee': doc['attendee'],
            'date': date,
          });
        }
      } catch (e) {
        print(
            'Failed to process document with ID: ${doc.id}'); // Print document ID if there's an error
        print('Error: $e'); // Print the error
      }
    }

    print(
        'Filtered citas for user $currentUserEmail: $citasList'); // Print filtered citas

    return citasList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: isAdmin
            ? FirebaseFirestore.instance.collection('citas').snapshots()
            : FirebaseFirestore.instance
                .collection('citas')
                .where('requester',
                    isEqualTo: FirebaseAuth.instance.currentUser?.email)
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              DateTime date = (data['date'] as Timestamp).toDate();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(date);
              return Card(
                color: Colors.blue[100], // Set the background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15.0), // Set the border radius
                ),
                child: ListTile(
                  title: Text('Debe asistir: ${data['requester']}'),
                  subtitle: Text(
                      'Asistente: ${data['attendee']}\nFecha: $formattedDate'),
                  trailing: isAdmin
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirmar Eliminacion'),
                                  content: const Text(
                                      'Esta seguro que desea borrar su pregunta?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Borrar'),
                                      onPressed: () {
                                        document.reference.delete();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : null,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
