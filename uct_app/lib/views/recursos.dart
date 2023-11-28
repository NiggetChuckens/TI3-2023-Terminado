// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uct_app/components/curso.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecursosPage extends StatelessWidget {
  final String email = FirebaseAuth.instance.currentUser?.email ?? "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Course>> fetchCourses() async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('cursos');
    List<Course> courseList = [];
    await courses.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        courseList.add(
          Course(
            courseName: doc['courseName'],
            backgroundImageUrl: doc['backgroundImageUrl'],
            registerDate:
                (doc['registerDate'] as Timestamp).toDate().toString(),
            Criterio: doc['Criterio'],
            Fechas: doc['Fechas'],
            Horario: doc['Horario'],
            Objetivo: doc['Objetivo'],
          ),
        );
      });
    });
    return courseList;
  }

  Future<void> registerUser(
      String courseName, String userEmail, BuildContext context) async {
    CollectionReference courses =
        FirebaseFirestore.instance.collection('cursos');

    var course = await courses.where('courseName', isEqualTo: courseName).get();

    if (course.docs.isNotEmpty) {
      String courseId = course.docs.first.id;

      Map<String, dynamic> courseData =
          course.docs.first.data() as Map<String, dynamic>;
      DateTime registerDate =
          (courseData['registerDate'] as Timestamp).toDate();
      if (DateTime.now().isAfter(registerDate)) {
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registration Closed'),
              content: const Text(
                  'The registration date for this course has expired.'),
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
        CollectionReference registrados =
            courses.doc(courseId).collection('registrados');
        await registrados.doc(userEmail).set({
          'email': userEmail,
          'registeredAt': FieldValue.serverTimestamp(),
        });
      }
    } else {
      print('No course found with the name $courseName');
    }
  }

  RecursosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Recursos',
          style: TextStyle(
            color: Color.fromARGB(255, 221, 221, 221),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Course>>(
          future: fetchCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF8FB5E1), Color(0xFFD190E0)],
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.transparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                    snapshot.data![index].backgroundImageUrl),
                              ),
                              const SizedBox(height: 10), // Add space
                              Text(
                                snapshot.data![index].courseName,
                                style: const TextStyle(
                                    fontSize: 20), // Increase font size
                              ),
                              const SizedBox(height: 10), // Add space
                              Text(
                                DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(
                                      snapshot.data![index].registerDate),
                                ),
                                style: const TextStyle(
                                    fontSize: 16), // Increase font size
                              ),
                              const SizedBox(height: 10), // Add space
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Confirmar Registro'),
                                            content: const Text(
                                                '¿Estás seguro de que quieres registrarte en este curso?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cancelar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Registrar'),
                                                onPressed: () {
                                                  registerUser(
                                                    snapshot.data![index]
                                                        .courseName,
                                                    email,
                                                    context, // Pass the context from the build method
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(
                                          0xFF8FB5E1), // Set the button color to light blue
                                      fixedSize: const Size(100, 50),
                                    ),
                                    child: const Text('Registrar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            title: Text(snapshot
                                                .data![index].courseName),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Image.network(snapshot
                                                      .data![index]
                                                      .backgroundImageUrl),
                                                  Text('Criterio: ' +
                                                      snapshot.data![index]
                                                          .Criterio),
                                                  Text('Fechas: ' +
                                                      snapshot
                                                          .data![index].Fechas),
                                                  Text('Horario: ' +
                                                      snapshot.data![index]
                                                          .Horario),
                                                  Text('Objetivo: ' +
                                                      snapshot.data![index]
                                                          .Objetivo),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cerrar'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(
                                          0xFF8FB5E1), // Set the button color to light blue
                                      fixedSize: const Size(
                                          100, 50), // Set the button size
                                    ),
                                    child: const Text('Ver'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
