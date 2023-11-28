import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart';

Future<String> uploadImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final File file = File(pickedFile.path);
    final fileExtension = extension(file.path).toLowerCase();

    // Check if the file is a jpg or png
    if (fileExtension != '.jpg' && fileExtension != '.png') {
      print('Archivo Invalido: Solo se permiten imagenes JPG y PNG.');
      return '';
    }

    final fileName = basename(file.path);
    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = firebaseStorageRef.putFile(file);
    await uploadTask.whenComplete(() => null);
    final downloadUrl = await firebaseStorageRef.getDownloadURL();

    return downloadUrl;
  } else {
    print('No image selected.');
    return '';
  }
}

Widget buildDteAdminTab(BuildContext context, Function deleteFunction,
    Function editFunction, Function addFunction) {
  return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('dte').snapshots(),
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
            String pfpLink =
                'https://firebasestorage.googleapis.com/v0/b/flutter-app-400102.appspot.com/o/Default.jpg?alt=media&token=2e6ebc34-bee5-4c6c-b8ea-7204769c092e'; // Replace with your specific link
            if (data.containsKey('pfp') &&
                data['pfp'] != null &&
                data['pfp'].toString().isNotEmpty) {
              pfpLink = data['pfp'];
            }
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(pfpLink),
                ),
                title: Text(data['nombre'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${data['email']}'),
                    Text('Especialidad: ${data['especialidad']}'),
                    Text('Grado: ${data['grado']}'),
                    Text('Rol: ${data['rol']}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editDte(context, 'dte', document),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteDte(context, 'dte', document),
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
        addDte(context, 'dte');
      },
    ),
  );
}

void editDte(
    BuildContext context, String collectionName, DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  TextEditingController nameController =
      TextEditingController(text: data['nombre']);
  TextEditingController emailController =
      TextEditingController(text: data['email']);
  TextEditingController especialidadController =
      TextEditingController(text: data['especialidad']);
  TextEditingController rolController =
      TextEditingController(text: data['rol']);
  TextEditingController pfpController =
      TextEditingController(text: data['pfp']);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Ficha de ${data['nombre']}'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: especialidadController,
                decoration: const InputDecoration(hintText: 'Especialidad'),
              ),
              TextField(
                controller: rolController,
                decoration: const InputDecoration(hintText: 'Rol'),
              ),
              TextField(
                controller: pfpController,
                decoration: const InputDecoration(hintText: 'Pfp'),
                enabled: false,
              ),
              ElevatedButton(
                child: const Text('Subir foto de perfil'),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text("Uploading..."),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  String imageUrl = await uploadImage();
                  Navigator.of(context).pop(); // Close the dialog
                  if (imageUrl.isNotEmpty) {
                    pfpController.text = imageUrl;
                  }
                },
              ),
            ],
          ),
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
              Map<String, dynamic> updatedData = {};
              if (nameController.text != data['nombre']) {
                updatedData['nombre'] = nameController.text;
                updatedData['lowercaseName'] =
                    nameController.text.toLowerCase();
              }
              if (emailController.text != data['email']) {
                updatedData['email'] = emailController.text;
              }
              if (especialidadController.text != data['especialidad']) {
                updatedData['especialidad'] = especialidadController.text;
              }
              if (rolController.text != data['rol']) {
                updatedData['rol'] = rolController.text;
              }
              if (pfpController.text != data['pfp']) {
                updatedData['pfp'] = pfpController.text;
              }
              if (updatedData.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confimar cambios'),
                      content: const Text(
                          'Esta seguro que desea guardar los cambios?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Confirmar'),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection(collectionName)
                                .doc(document.id)
                                .update(updatedData);
                            Navigator.of(context)
                                .pop(); // pop the confirmation dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Editado Exitoso!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
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

void deleteDte(
    BuildContext context, String collectionName, DocumentSnapshot document) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Eliminar Ficha de ${document['nombre']}'),
        content: const Text('Esta seguro que desea eliminar esta ficha?'),
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

void addDte(BuildContext context, String collectionName) {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController rolController = TextEditingController();
  TextEditingController pfpController = TextEditingController();
  TextEditingController gradoController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Agregar Funcionario'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: especialidadController,
                decoration: const InputDecoration(hintText: 'Especialidad'),
              ),
              TextField(
                controller: gradoController,
                decoration: const InputDecoration(hintText: 'Grado'),
              ),
              TextField(
                controller: rolController,
                decoration: const InputDecoration(hintText: 'Rol'),
              ),
              TextField(
                controller: pfpController,
                decoration: const InputDecoration(hintText: 'Pfp'),
              ),
              ElevatedButton(
                child: const Text('Subir foto de perfil'),
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text("Uploading..."),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  String imageUrl = await uploadImage();
                  Navigator.of(context).pop(); // Close the dialog
                  if (imageUrl.isNotEmpty) {
                    pfpController.text = imageUrl;
                  }
                },
              ),
            ],
          ),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmar Agregar Funcionario'),
                    content: const Text(
                        'Esta seguro que desea agregar este funcionario?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Confirmar'),
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              especialidadController.text.isEmpty ||
                              rolController.text.isEmpty ||
                              pfpController.text.isEmpty) {
                            // Show a dialog if any field is empty
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Todos los campos son obligatorios.'),
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
                            // Check if the email already exists in the database
                            FirebaseFirestore.instance
                                .collection(collectionName)
                                .where('email', isEqualTo: emailController.text)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              if (querySnapshot.docs.isNotEmpty) {
                                // Show a dialog if the email already exists
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Este correo ya existe en la lista.'),
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
                                // Check if the name already exists in the database
                                FirebaseFirestore.instance
                                    .collection(collectionName)
                                    .where('nombre',
                                        isEqualTo: nameController.text)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  if (querySnapshot.docs.isNotEmpty) {
                                    // Show a dialog if the name already exists
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'Este nombre ya existe en la lista.'),
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
                                    // Add the new DTE if the email and name do not exist
                                    FirebaseFirestore.instance
                                        .collection(collectionName)
                                        .add({
                                      'nombre': nameController.text,
                                      'lowercaseName':
                                          nameController.text.toLowerCase(),
                                      'email': emailController.text,
                                      'especialidad':
                                          especialidadController.text,
                                      'rol': rolController.text,
                                      'pfp': pfpController.text,
                                    });
                                    Navigator.of(context)
                                        .pop(); // pop the dialog
                                  }
                                });
                              }
                            });
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      );
    },
  );
}
