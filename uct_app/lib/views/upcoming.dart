import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({super.key});

  @override
  _UpcomingEventsPageState createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  late Future<List<Map<String, dynamic>>> futureCitas;

  @override
  void initState() {
    super.initState();
    futureCitas = fetchCitas();
  }

 Future<List<Map<String, dynamic>>> fetchCitas() async {
  CollectionReference citas = FirebaseFirestore.instance.collection('citas');
  String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

  List<Map<String, dynamic>> citasList = [];

  await citas.where('requester', isEqualTo: currentUserEmail).get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
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
        print('Failed to process document with ID: ${doc.id}'); // Print document ID if there's an error
        print('Error: $e'); // Print the error
      }
    });
  });

  print('Filtered citas for user $currentUserEmail: $citasList'); // Print filtered citas

  return citasList;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureCitas,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('An error has occurred'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Debe asistir: ${snapshot.data![index]['requester']}'),
                  subtitle: Text('Asistente: ${snapshot.data![index]['attendee']}\nFecha: ${snapshot.data![index]['date']}'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}