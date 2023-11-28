import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/about.dart';
import 'package:uct_app/components/specialists.dart';

class SpecialistPage extends StatefulWidget {
  const SpecialistPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpecialistPageState createState() => _SpecialistPageState();
}

class _SpecialistPageState extends State<SpecialistPage> {
  late Future<List<Specialist>> futureSpecialists;
  String dropdownValue = 'Todos';
  List<String> roles = ['Todos'];

  @override
  void initState() {
    super.initState();
    futureSpecialists = fetchSpecialists('Todos');
    fetchRoles().then((fetchedRoles) {
      setState(() {
        roles = fetchedRoles;
        roles.insert(0, 'Todos');
      });
    });
  }

  Future<List<Specialist>> fetchSpecialists(String rol) async {
    CollectionReference specialists =
        FirebaseFirestore.instance.collection('dte');

    List<Specialist> specialistList = [];

    await specialists.get().then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      print('Document data: $data'); // Print document data

      try {
        if (rol == 'Todos' || doc['rol'] == rol) {
          String pfpLink = 'https://firebasestorage.googleapis.com/v0/b/flutter-app-400102.appspot.com/o/Default.jpg?alt=media&token=2e6ebc34-bee5-4c6c-b8ea-7204769c092e'; // Replace with your specific link
          if (data != null && data.containsKey('pfp') && data['pfp'] != null && data['pfp'].toString().isNotEmpty) {
            pfpLink = data['pfp'];
          }
          specialistList.add(
            Specialist(
              name: doc['nombre'],
              email: doc['email'],
              grado: doc['grado'],
              rol: doc['rol'],
              especialidad: doc['especialidad'],
              pfp: pfpLink,
            ),
          );
        }
      } catch (e) {
        print(
            'Failed to process document with ID: ${doc.id}'); // Print document ID if there's an error
        print('Error: $e'); // Print the error
      }
    }
  });

    return specialistList;
  }

  Future<List<String>> fetchRoles() async {
    CollectionReference specialists =
        FirebaseFirestore.instance.collection('dte');
    List<String> rolesList = [];

    await specialists.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        try {
          String role = doc['rol'];
          if (!rolesList.contains(role)) {
            rolesList.add(role);
          }
        } catch (e) {
          print(
              'Failed to process document with ID: ${doc.id}'); // Print document ID if there's an error
          print('Error: $e'); // Print the error
        }
      }
    });

    return rolesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Especialistas',
          style: TextStyle(
            color: Color.fromARGB(255, 221, 221, 221),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5.0,
        actions: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                futureSpecialists = fetchSpecialists(dropdownValue);
              });
            },
            items: roles.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/cnfondo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder<List<Specialist>>(
                future: futureSpecialists,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('An error has occurred'));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            0.8, // Adjust this value to change the height of the boxes
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EspecialistaDetails(
                                      specialist: snapshot.data![index]),
                                ),
                              );
                            },
                            child: Center(
                              child: SizedBox(
                                width: 150, // Set your desired width here
                                child: Card(
                                  color: const Color.fromARGB(255, 42, 42,
                                      42), // Dark background for the card
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            snapshot.data![index].pfp,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          snapshot.data![index].name,
                                          textAlign: TextAlign
                                              .center, // Center the names
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(
                                                0xFFE0E0E0), // Light text color for contrast
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          snapshot.data![index].rol,
                                          textAlign: TextAlign
                                              .center, // Center the roles
                                          style: const TextStyle(
                                            color: Color(
                                                0xFF757575), // Slightly lighter grey for contrast
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}