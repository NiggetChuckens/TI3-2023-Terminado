import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

final User? user = FirebaseAuth.instance.currentUser;
final String userEmail = user?.email ?? '';

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

Widget buildCoursesTab(BuildContext context, Function deleteFunction,
    Function editFunction, Function addFunction) {
  return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cursos').snapshots(),
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
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(data['courseName'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      data['backgroundImageUrl'],
                      height: 100, // Adjust as needed
                      width: 100, // Adjust as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => editCourse(context, 'cursos', document),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: userEmail.endsWith(document.id)
                          ? null
                          : () => deleteCourse(context, 'cursos', document),
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
        addFunction(context, 'cursos');
      },
    ),
  );
}

void editCourse(
    BuildContext context, String collectionName, DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  TextEditingController backgroundImageUrlController =
      TextEditingController(text: data['backgroundImageUrl']);
  TextEditingController courseNameController =
      TextEditingController(text: data['courseName']);
  TextEditingController registerDateController = TextEditingController(
      text: (data['registerDate'] as Timestamp).toDate().toString());
  TextEditingController criterioController =
      TextEditingController(text: data['Criterio'] ?? "");
  TextEditingController fechasController =
      TextEditingController(text: data['Fechas'] ?? "");
  TextEditingController horarioController =
      TextEditingController(text: data['Horario'] ?? "");
  TextEditingController objetivoController =
      TextEditingController(text: data['Objetivo'] ?? "");

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Curso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: backgroundImageUrlController,
                decoration: const InputDecoration(
                    hintText: 'URL de la imagen de fondo'),
                enabled: false,
              ),
              ElevatedButton(
                child: const Text('Subir imagen de fondo'),
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
                              child: Text("Subiendo..."),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  String imageUrl = await uploadImage();
                  Navigator.of(context).pop(); // Close the dialog
                  if (imageUrl.isNotEmpty) {
                    backgroundImageUrlController.text = imageUrl;
                  }
                },
              ),
              TextField(
                controller: courseNameController,
                decoration: const InputDecoration(hintText: 'Nombre del curso'),
              ),
              TextField(
                controller: registerDateController,
                decoration:
                    const InputDecoration(hintText: 'Fecha de registro'),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(registerDateController.text),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    registerDateController.text = pickedDate.toString();
                  }
                },
              ),
              TextField(
                controller: criterioController,
                decoration: const InputDecoration(hintText: 'Criterio'),
              ),
              TextField(
                controller: fechasController,
                decoration: const InputDecoration(hintText: 'Fechas'),
              ),
              TextField(
                controller: horarioController,
                decoration: const InputDecoration(hintText: 'Horario'),
              ),
              TextField(
                controller: objetivoController,
                decoration: const InputDecoration(hintText: 'Objetivo'),
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
              Map<String, dynamic> updatedData = {
                'backgroundImageUrl': backgroundImageUrlController.text,
                'courseName': courseNameController.text,
                'registerDate': Timestamp.fromDate(
                    DateTime.parse(registerDateController.text)),
                'Criterio': criterioController.text,
                'Fechas': fechasController.text,
                'Horario': horarioController.text,
                'Objetivo': objetivoController.text,
              };

              FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(document.id)
                  .update(updatedData);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void deleteCourse(
    BuildContext context, String collectionName, DocumentSnapshot document) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Eliminar Ficha de ${document['courseName']}'),
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

void addCourse(BuildContext context, String collectionName) {
  TextEditingController backgroundImageUrlController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController registerDateController = TextEditingController();
  TextEditingController criterioController = TextEditingController();
  TextEditingController fechasController = TextEditingController();
  TextEditingController horarioController = TextEditingController();
  TextEditingController objetivoController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Agregar Curso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: backgroundImageUrlController,
                decoration: const InputDecoration(
                    hintText: 'URL de la imagen de fondo'),
                enabled: false,
              ),
              ElevatedButton(
                child: const Text('Subir imagen de fondo'),
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
                              child: Text("Subiendo..."),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  String imageUrl = await uploadImage();
                  Navigator.of(context).pop(); // Close the dialog
                  if (imageUrl.isNotEmpty) {
                    backgroundImageUrlController.text = imageUrl;
                  }
                },
              ),
              TextField(
                controller: courseNameController,
                decoration: const InputDecoration(hintText: 'Nombre del curso'),
              ),
              TextField(
                controller: registerDateController,
                decoration:
                    const InputDecoration(hintText: 'Fecha de registro'),
              ),
              TextField(
                controller: criterioController,
                decoration: const InputDecoration(hintText: 'Criterio'),
              ),
              TextField(
                controller: fechasController,
                decoration: const InputDecoration(hintText: 'Fechas'),
              ),
              TextField(
                controller: horarioController,
                decoration: const InputDecoration(hintText: 'Horario'),
              ),
              TextField(
                controller: objetivoController,
                decoration: const InputDecoration(hintText: 'Objetivo'),
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
              if (backgroundImageUrlController.text.isEmpty ||
                  courseNameController.text.isEmpty ||
                  registerDateController.text.isEmpty ||
                  criterioController.text.isEmpty ||
                  fechasController.text.isEmpty ||
                  horarioController.text.isEmpty ||
                  objetivoController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Todos los campos son obligatorios.'),
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
                FirebaseFirestore.instance.collection(collectionName).add({
                  'backgroundImageUrl': backgroundImageUrlController.text,
                  'courseName': courseNameController.text,
                  'registerDate': Timestamp.fromDate(
                      DateTime.parse(registerDateController.text)),
                  'Criterio': criterioController.text,
                  'Fechas': fechasController.text,
                  'Horario': horarioController.text,
                  'Objetivo': objetivoController.text,
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
