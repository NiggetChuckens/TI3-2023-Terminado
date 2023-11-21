import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class QuestionForumPage extends StatefulWidget {
  @override
  _QuestionForumPageState createState() => _QuestionForumPageState();
}

class _QuestionForumPageState extends State<QuestionForumPage> {
  final _questions = FirebaseFirestore.instance.collection('foro');
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final String _email = FirebaseAuth.instance.currentUser?.email ?? "";

  Future<void> _addQuestion() async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _bodyController = TextEditingController();
    final User? _currentUser = FirebaseAuth.instance.currentUser;
    final String _email = _currentUser?.email ?? "";
    final String _profilePic = _currentUser?.photoURL ?? "";
    final DateTime _date = DateTime.now();
    final String _fullName = _currentUser?.displayName ?? "";
    final List<String> _nameParts = _fullName.split(' ');
    final String _shortName =
        _nameParts.length > 1 ? '${_nameParts[0]} ${_nameParts[1]}' : _fullName;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cual es su pregunta?'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Titulo de la pregunta",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      hintText: "Ingresar pregunta aqui",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Enviar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                _questions.add({
                  'title': _titleController.text,
                  'body': _bodyController.text,
                  'email': _email,
                  'profilePic': _profilePic,
                  'date': _date,
                  'shortName': _shortName,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addReply(DocumentReference questionRef) async {
    final TextEditingController _replyController = TextEditingController();
    final User? _currentUser = FirebaseAuth.instance.currentUser;
    final String _email = _currentUser?.email ?? "";
    final String _fullName = _currentUser?.displayName ?? "";
    final List<String> _nameParts = _fullName.split(' ');
    final String _shortName =
        _nameParts.length > 1 ? '${_nameParts[0]} ${_nameParts[1]}' : _fullName;

    final DateTime _date = DateTime.now();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingresar Respuesta'),
          content: TextField(
            controller: _replyController,
            decoration: const InputDecoration(hintText: "Ingresar Respuesta"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                questionRef.collection('replies').add({
                  'reply': _replyController.text,
                  'name': _shortName,
                  'email': _email,
                  'date': _date,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foro de Preguntas'),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          tooltip: 'Volver atras',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {}, // Handle your functionality here
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _questions.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return GestureDetector(
                onTap: () async {
                  final repliesSnapshot =
                      await document.reference.collection('replies').get();
                  final replies =
                      repliesSnapshot.docs.map((doc) => doc.data()).toList();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Material(
                          elevation: 5.0, // This adds elevation
                          borderRadius: BorderRadius.circular(
                              15.0), // This makes the border rounded
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              (document.data()
                                      as Map<String, dynamic>)['title'] ??
                                  '',
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        content: SizedBox(
                          height: 300.0, // Set the height to your desired value

                          child: SingleChildScrollView(
                            child: Column(
                              children: replies
                                  .map((reply) => Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.grey[200],
                                        elevation: 5.0,
                                        child: ListTile(
                                          title: Text(reply['reply']),
                                          subtitle: Text(
                                              '\n${reply['name']}\n${DateFormat('yyyy-MM-dd HH:mm').format(reply['date'].toDate())}'),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  print(replies.length.toString()); // Use replies here
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              (document.data()
                                      as Map<String, dynamic>)['profilePic'] ??
                                  'https://firebasestorage.googleapis.com/v0/b/flutter-app-400102.appspot.com/o/Default.jpg?alt=media&token=2e6ebc34-bee5-4c6c-b8ea-7204769c092e',
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Add some space between the picture and the name
                          Text(
                            (document.data()
                                    as Map<String, dynamic>)['shortName'] ??
                                '',
                            style: TextStyle(
                                fontSize: 16), // Adjust the style as needed
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          (document.data() as Map<String, dynamic>)['title'] ??
                              '',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Text(
                                (document.data()
                                        as Map<String, dynamic>)['body'] ??
                                    '',
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm').format(
                              (document.data() as Map<String, dynamic>)['date']
                                  .toDate(),
                            ),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.reply),
                            onPressed: () {
                              _addReply(document.reference);
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: document.reference
                                .collection('replies')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return Text('${snapshot.data!.docs.length}');
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.thumb_up),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.thumb_down),
                            onPressed: () {
                              // Handle dislike button press
                            },
                          ),
                          if (_email ==
                              (document.data()
                                  as Map<String, dynamic>)['email'])
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Confirmar Eliminacion'),
                                      content: const Text(
                                          'Esta seguro que desea borrar su pregunta?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () {
                                            document.reference.delete();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                        ],
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
        onPressed: _addQuestion,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
