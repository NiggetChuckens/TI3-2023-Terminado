import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String getCurrentUserEmail() {
  final User? user = FirebaseAuth.instance.currentUser;
  return user?.email ?? '';
}

Widget buildAdminAccessTab(
    Function editFunction, Function deleteFunction, Function addFunction) {
  return Builder(
    builder: (BuildContext context) {
      return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('administradores')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    title: Text(document.id,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: document.id == getCurrentUserEmail()
                              ? null
                              : () => editAdmin(
                                  context, 'administradores', document),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: document.id == getCurrentUserEmail()
                              ? null
                              : () => deleteAdmin(context, 'administradores',
                                  document, getCurrentUserEmail()),
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
            addAdmin(context, 'administradores');
          },
        ),
      );
    },
  );
}

void editAdmin(
    BuildContext context, String collectionName, DocumentSnapshot document) {
  TextEditingController controller = TextEditingController(text: document.id);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar Administrador'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Ingresar nuevo correo"),
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
              FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(document.id)
                  .update({'email': controller.text});
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void deleteAdmin(BuildContext context, String collectionName,
    DocumentSnapshot document, String currentUserEmail) {
  if (document.id == currentUserEmail) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se puede eliminar a si mismo!')));
    return;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmar Eliminacion'),
        content:
            const Text('Esta seguro que desea eliminar este administrador?'),
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
              FirebaseFirestore.instance
                  .collection(collectionName)
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

void addAdmin(BuildContext context, String collectionName) {
  TextEditingController controller = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Admin'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter email"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () async {
              final String email = controller.text;
              final DocumentSnapshot doc = await FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(email)
                  .get();
              if (doc.exists) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('This email is already an admin.')));
              } else {
                FirebaseFirestore.instance
                    .collection(collectionName)
                    .doc(email)
                    .set({});
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
