import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Widget buildCitasTab(BuildContext context) {
  void deleteCita(DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Cita'),
          content: const Text('Are you sure you want to delete this cita?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('citas')
                    .doc(document.id)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('citas').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }

      return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          DateTime date = data['date'].toDate();
          String formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(date);
          
          return ListTile(
            title: Text('ID Cita: ${document.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Asistente: ${data['attendee']}'),
                Text('Nombre del Asistente: ${data['attendeeName']}'),
                Text('Fecha: $formattedDate'),
                Text('Solicitante: ${data['requester']}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteCita(document);
              },
            ),
          );
        }).toList(),
      );
    },
  );
}