import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String getCurrentUserEmail() {
  final User? user = FirebaseAuth.instance.currentUser;
  return user?.email ?? '';
}

Widget buildBloqueadosTab() {
  return Builder(
    builder: (BuildContext context) {
      return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('bloqueados').snapshots(),
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
              icon: const Icon(Icons.edit),
              onPressed: document.id == getCurrentUserEmail() ? null : () => editBloqueado(context, 'bloqueados', document),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: document.id == getCurrentUserEmail() ? null : () => deleteBloqueado(context, 'bloqueados', document),
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
          onPressed: () {
            addBloqueado(context, 'bloqueados');
          },
          child: const Icon(Icons.add),
        ),
      );
    },
  );
}


void addBloqueado(BuildContext context, String collectionName) {
  TextEditingController controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Añadir bloqueado'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Email'),
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
            content: const Text('Campo vacio, por favor ingrese un correo valido'),
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
    } else if (controller.text == getCurrentUserEmail()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No puedes bloquearte a ti mismo'),
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
void editBloqueado(BuildContext context, String collectionName, DocumentSnapshot document) {
  TextEditingController controller = TextEditingController(text: document.id);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar Bloqueados'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Email'),
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
            content: const Text('Correo no puede estar vacio'),
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
    } else if (controller.text == getCurrentUserEmail()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No te puedes bloquear a ti mismo'),
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
                      title: const Text('Confirmar'),
                      content: const Text('Esta seguro que desea cambiar el correo de este bloqueado?'),
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
                            FirebaseFirestore.instance.collection(collectionName).doc(document.id).update({'email': controller.text});
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(); // pop the confirmation dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}

//need a edit function for bloqueados with checks so i can't edit myself into a bloqueado or add myself as a bloqueado, also add confirmation dialog
//need a delete function for bloqueados with checks so i can't delete myself as a bloqueado, also add confirmation dialog

void deleteBloqueado(BuildContext context, String collectionName, DocumentSnapshot document) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar Bloqueado'),
        content: const Text('Esta seguro que desea desbloquear a este usuario?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              FirebaseFirestore.instance.collection(collectionName).doc(document.id).delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}