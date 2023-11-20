import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uct_app/views/landing.dart';

class TopBar extends StatelessWidget {
  final String username;
  final String photoUrl;
  final String email;

  const TopBar(
      {Key? key,
      required this.username,
      required this.photoUrl,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido,',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) => Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 300),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(
                                          height:
                                              120), // to accommodate the profile picture
                                      Text(username,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      Text(email),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LandingPage()), // replace LoginPage() with your login page widget
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: const Text('Cerrar sesión'),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          photoUrl,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(225, 225, 225, 225),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        photoUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
