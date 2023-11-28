import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uct_app/components/curso.dart';
import 'package:intl/intl.dart';

class RecursosPage extends StatelessWidget {
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
          ),
        );
      });
    });

    return courseList;
  }

  const RecursosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding:
                        const EdgeInsets.all(8.0), // Add padding between cards
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF8FB5E1), Color(0xFFD190E0)],
                        ),
                        borderRadius:
                            BorderRadius.circular(15.0), // Add rounded corners
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Add rounded corners to the card
                        ),
                        color: Colors
                            .transparent, // Make the card transparent to show the gradient
                        elevation: 0, // Remove shadow
                        child: Padding(
                          padding: const EdgeInsets.all(
                              16.0), // Add padding inside the card
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
                                      // Add your code for the "Registrar" button here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(
                                          0xFF8FB5E1), // Set the button color to light blue
                                      fixedSize:
                                          const Size(110, 50), // Set the button size
                                    ),
                                    child: const Text('Registrar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your code for the "Ver" button here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(
                                          0xFF8FB5E1), // Set the button color to light blue
                                      fixedSize:
                                          const Size(100, 50), // Set the button size
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
