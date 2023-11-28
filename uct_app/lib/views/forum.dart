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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String email = currentUser?.email ?? "";
    final String profilePic = currentUser?.photoURL ?? "";
    final DateTime date = DateTime.now();
    final String fullName = currentUser?.displayName ?? "";
    final List<String> nameParts = fullName.split(' ');
    final String shortName =
        nameParts.length > 1 ? '${nameParts[0]} ${nameParts[1]}' : fullName;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20), // Increase the border radius to make the dialog more rounded
          ),
          title: const Center(child: Text('Cual es su pregunta?')),
          content: SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                Container(
                  width: 300, // Set the width to your desired value
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Change the color to blue
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      // Add a shadow
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: "Titulo de la pregunta",
                      border: InputBorder.none,

                      hintStyle: TextStyle(color: Colors.white),
                      // Add color to the text
                    ),

                    style:
                        const TextStyle(color: Colors.white), // Add this line
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300, // Set the width to your desired value
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      // Add a shadow
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: bodyController,
                    maxLines:
                        null, // This makes the TextField expand vertically
                    minLines:
                        3, // This sets the minimum lines for the TextField
                    decoration: const InputDecoration(
                      hintText: "Descripcion",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 0, 0, 0)), // Add color to the text
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                _questions.add({
                  'title': titleController.text,
                  'body': bodyController.text,
                  'email': email,
                  'profilePic': profilePic,
                  'date': date,
                  'shortName': shortName,
                  'likes': 0,
                  'dislikes': 0,
                  'likedBy': [],
                  'dislikedBy': [],
                });
                Navigator.of(context).pop();
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addReply(DocumentReference questionRef) async {
    final TextEditingController replyController = TextEditingController();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String email = currentUser?.email ?? "";
    final String fullName = currentUser?.displayName ?? "";
    final List<String> nameParts = fullName.split(' ');
    final String shortName =
        nameParts.length > 1 ? '${nameParts[0]} ${nameParts[1]}' : fullName;

    final DateTime date = DateTime.now();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Ingresar Respuesta')),
          content: Container(
            width: 300.0,
            height: 100.0,
            child: TextField(
              controller: replyController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0), // Add padding to the top
              ),
              style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis), // Make text scrollable
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                questionRef.collection('replies').add({
                  'reply': replyController.text,
                  'name': shortName,
                  'email': email,
                  'date': date,
                  'likes': 0,
                  'dislikes': 0,
                  'likedBy': [],
                  'dislikedBy': [],
                });
                Navigator.of(context).pop();
              },
              child: const Text('Enviar'),
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
        title: const Text('Foro de Preguntas'),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'Volver atras',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
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
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              (document.data()
                                  as Map<String, dynamic>)['title'],
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        content: Container(
                          height: 300.0,
                          width: 300.0,
                          decoration: BoxDecoration(
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
                          child: StreamBuilder<QuerySnapshot>(
                            stream: document.reference
                                .collection('replies')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              final replies = snapshot.data!.docs
                                  .map((doc) =>
                                      doc.data() as Map<String, dynamic>)
                                  .toList();
                              return SingleChildScrollView(
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
                                              title: Text(reply['reply'] ?? ''),
                                              subtitle: Text(
                                                  '${reply['name'] ?? ''}\n${DateFormat('yyyy-MM-dd HH:mm').format((reply['date'] as Timestamp?)?.toDate() ?? DateTime.now())}'),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                  print(replies.length.toString());
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(width: 10),
                          Text(
                            (document.data()
                                    as Map<String, dynamic>)['shortName'] ??
                                '',
                            style: const TextStyle(fontSize: 16),
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
                          const SizedBox(width: 10),
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
                          StreamBuilder<DocumentSnapshot>(
                            stream: document.reference.snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              final likes = data['likes'] ?? 0;
                              final dislikes = data['dislikes'] ?? 0;
                              final likedBy = data['likedBy'] ?? [];
                              final dislikedBy = data['dislikedBy'] ?? [];
                              final userId =
                                  FirebaseAuth.instance.currentUser?.uid;

                              return Row(
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
                                        return Text(
                                            '${snapshot.data!.docs.length}');
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up),
                                    onPressed: () {
                                      if (!likedBy.contains(userId)) {
                                        document.reference.update({
                                          'likes': FieldValue.increment(1),
                                          'likedBy':
                                              FieldValue.arrayUnion([userId]),
                                          'dislikes':
                                              dislikedBy.contains(userId)
                                                  ? FieldValue.increment(-1)
                                                  : 0,
                                          'dislikedBy':
                                              FieldValue.arrayRemove([userId])
                                        });
                                      }
                                    },
                                  ),
                                  Text('$likes'),
                                  IconButton(
                                    icon: const Icon(Icons.thumb_down),
                                    onPressed: () {
                                      if (!dislikedBy.contains(userId)) {
                                        document.reference.update({
                                          'dislikes': FieldValue.increment(1),
                                          'dislikedBy':
                                              FieldValue.arrayUnion([userId]),
                                          'likes': likedBy.contains(userId)
                                              ? FieldValue.increment(-1)
                                              : 0,
                                          'likedBy':
                                              FieldValue.arrayRemove([userId])
                                        });
                                      }
                                    },
                                  ),
                                  Text('$dislikes'),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('administradores')
                                        .doc(_email)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      } else if ((snapshot.hasData &&
                                              snapshot.data!.exists) ||
                                          _email ==
                                              (document.data() as Map<String,
                                                  dynamic>)['email']) {
                                        // The user is an admin or the owner of the post
                                        return Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                _editQuestion(
                                                    document.reference,
                                                    document.data() as Map<
                                                        String, dynamic>);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirmar Eliminacion'),
                                                      content: const Text(
                                                          'Esta seguro que desea borrar su pregunta?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Cancelar'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            document.reference
                                                                .delete();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Borrar'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                ],
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
        tooltip: 'Agregar Pregunta',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _editQuestion(
      DocumentReference questionRef, Map<String, dynamic> questionData) async {
    final TextEditingController _titleController =
        TextEditingController(text: questionData['title']);
    final TextEditingController _bodyController =
        TextEditingController(text: questionData['body']);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20), // Increase the border radius to make the dialog more rounded
          ),
          title: const Center(child: Text('Editar Pregunta')),
          content: SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                Container(
                  width: 300, // Set the width to your desired value
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Change the color to blue
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      // Add a shadow
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Titulo de la pregunta",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.white), // Add color to the text
                    ),
                    style:
                        const TextStyle(color: Colors.white), // Add this line
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300, // Set the width to your desired value
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      // Add a shadow
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _bodyController,
                    maxLines:
                        null, // This makes the TextField expand vertically
                    minLines:
                        3, // This sets the minimum lines for the TextField
                    decoration: const InputDecoration(
                      hintText: "Descripcion",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 0, 0, 0)), // Add color to the text
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                questionRef.update({
                  'title': _titleController.text,
                  'body': _bodyController.text,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
