import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final User? user = FirebaseAuth.instance.currentUser;
final String userEmail = user?.email ?? '';

  Widget buildDomainAccessTab(BuildContext context, Function deleteFunction,
    Function editFunction, Function addFunction) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('dominiospermitidos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
  children: snapshot.data!.docs.map((DocumentSnapshot document) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(document.id, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            IconButton(
  icon: const Icon(Icons.delete),
  onPressed: userEmail.endsWith(document.id) ? null : () => deleteDomain(context, document),
),
          ],
        ),
      ),
    );
  }).toList(),
);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addDominio(context, 'dominiospermitidos');
        },
      ),
    );
  }

void editDominio(BuildContext context, String collectionName, DocumentSnapshot document) {
  TextEditingController controller = TextEditingController(text: document.id);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar Dominio'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Dominio'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Guardar'),
            onPressed: () {
              if (controller.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Dominio no puede estar vacio'),
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
                FirebaseFirestore.instance.collection(collectionName).doc(document.id).update({'dominio': controller.text});
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

void deleteDomain(BuildContext context, DocumentSnapshot document) {
  final String domain = document.id;
  if (userEmail.endsWith(domain)) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('No se puede eliminar! Correo actual pertenece a este dominio'),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminacion'),
          content: const Text('Esta seguro que desea eliminar este dominio?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Si'),
              onPressed: () {
                FirebaseFirestore.instance.collection('dominiospermitidos').doc(document.id).delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void addDominio(BuildContext context, String collectionName) {
  TextEditingController controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Añadir dominio'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Dominio'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Agregar'),
            onPressed: () {
              if (controller.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Campo vacio, por favor ingrese un dominio valido'),
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
                FirebaseFirestore.instance.collection(collectionName).doc(controller.text).set({});
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}