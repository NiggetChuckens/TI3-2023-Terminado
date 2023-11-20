import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uct_app/components/perfil.dart';

class Busqueda extends StatefulWidget {
  final LinearGradient gradientSearch;

  const Busqueda({Key? key, required this.gradientSearch}) : super(key: key);

  @override
  _BusquedaState createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: widget.gradientSearch,
          color: const Color.fromARGB(255, 232, 196, 233),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search),
            hintText: 'Que estas buscando?',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _search();
                _showResults();
              },
            ),
          ),
          onSubmitted: (value) {
            _search();
            _showResults();
          },
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _search() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('dte')
        .get();

    return snapshot.docs
        .where((doc) => doc['lowercaseName'].contains(_controller.text.toLowerCase()))
        .toList();
  }

void _showResults() {
 showModalBottomSheet(
 context: context,
 backgroundColor: Colors.white.withOpacity(0.9), // semi-transparent white
 builder: (context) {
   return FutureBuilder<List<DocumentSnapshot>>(
     future: _search(),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return const Center(child: CircularProgressIndicator());
       } else if (snapshot.hasError) {
         return Text('Error: ${snapshot.error}');
       } else {
         return Column(
           children: [
             AppBar(
              title: const DefaultTextStyle(
               style: TextStyle(color: Colors.black, fontSize: 20),
               child: Text('Busqueda'),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(
               color: Colors.black,
              ),
             ),
             Expanded(
              child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
               child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data![index];
                  Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
                  String pfp = docData.containsKey('pfp') ? doc['pfp'] : 'https://firebasestorage.googleapis.com/v0/b/flutter-app-400102.appspot.com/o/Default.jpg?alt=media&token=2e6ebc34-bee5-4c6c-b8ea-7204769c092e'; // replace with actual static profile picture URL
                  return Card(
                    child: ListTile(
                      title: Text(doc['nombre']),
                      subtitle: Text('Email: ${doc['email']}\nEspecialidad: ${doc['especialidad']}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                           return ProfilePopup(
                             grado: doc['grado'],
                             rol: doc['rol'],
                             especialidad: doc['especialidad'],
                             email: doc['email'],
                             name: doc['nombre'],
                             profilePicture: pfp,
                           );
                          },
                        );
                      },
                    ),
                  );
                },
               ),
              ),
             ),
           ],
         );
       }
     },
   );
 },
 );
}



}